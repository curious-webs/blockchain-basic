echo "Generate ORG Certificate"

cryptogen generate --config=organizations/cryptogen/crypto-config-google.yaml --output="TWG" 

echo "generating Channel JSON"
 
export FABRIC_CFG_PATH=${PWD}/configtx-addorg
configtxgen -printOrg GOOGLE > channel-artifacts/google.json

echo "Docker UP"
docker compose -f docker/docker-compose-google-net.yaml up -d


export CHANNEL_NAME=mychannel
export ORDERER_CA=${PWD}/TWG/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem 

export FABRIC_CFG_PATH=../config
export CORE_PEER_LOCALMSPID="TCSMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/TWG/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/TWG/peerOrganizations/tcs.com/users/Admin@tcs.com/msp
export CORE_PEER_ADDRESS=localhost:7051
export CORE_PEER_TLS_ENABLED=true
  
echo "Fetch Channel Configuration"
peer channel fetch config channel-artifacts-org/${CHANNEL_NAME}_block.pb -o localhost:7050  -c $CHANNEL_NAME --tls --cafile $ORDERER_CA  
   

echo "Convert to JSON"
configtxlator proto_decode --input channel-artifacts-org/${CHANNEL_NAME}_block.pb --type common.Block --output channel-artifacts-org/${CHANNEL_NAME}_block.json

echo "remove all the headers, metadata, and signatures"
jq .data.data[0].payload.data.config channel-artifacts-org/${CHANNEL_NAME}_block.json > channel-artifacts-org/${CHANNEL_NAME}_config.json 


echo "Add ORG to JSON"
jq -s '.[0] * {"channel_group":{"groups":{"Application":{"groups": {"GOOGLE":.[1]}}}}}' channel-artifacts-org/${CHANNEL_NAME}_config.json channel-artifacts/google.json > channel-artifacts-org/modified_anchor_${CHANNEL_NAME}.json
   

echo "Converting  Config Json back to PB block"
configtxlator proto_encode --input channel-artifacts-org/${CHANNEL_NAME}_config.json --type common.Config --output channel-artifacts-org/${CHANNEL_NAME}_config.pb


echo "Converting  Modified config Json back to PB block"
configtxlator proto_encode --input channel-artifacts-org/modified_anchor_${CHANNEL_NAME}.json --type common.Config --output channel-artifacts-org/modified_anchor_${CHANNEL_NAME}.pb


echo "Calculate Delta between two pb blocks orginal abd modified"
configtxlator compute_update --channel_id $CHANNEL_NAME --original channel-artifacts-org/${CHANNEL_NAME}_config.pb --updated channel-artifacts-org/modified_anchor_${CHANNEL_NAME}.pb --output channel-artifacts-org/anchor_update_${CHANNEL_NAME}.pb


echo "Convert Difference PB back to JSON"
configtxlator proto_decode --input channel-artifacts-org/anchor_update_${CHANNEL_NAME}.pb --type common.ConfigUpdate --output channel-artifacts-org/anchor_update_${CHANNEL_NAME}.json

echo "Wrap into Enevelop - add headers, metadata and signature that was removed"
echo '{"payload":{"header":{"channel_header":{"channel_id":"mychannel", "type":2}},"data":{"config_update":'$(cat channel-artifacts-org/anchor_update_${CHANNEL_NAME}.json)'}}}' | jq . > channel-artifacts-org/anchor_update_${CHANNEL_NAME}_in_envelope.json

  
echo "Convert again to a block "
configtxlator proto_encode --input channel-artifacts-org/anchor_update_${CHANNEL_NAME}_in_envelope.json --type common.Envelope --output channel-artifacts-org/anchor_update_${CHANNEL_NAME}_in_envelope.pb 

peer channel signconfigtx -f channel-artifacts-org/anchor_update_${CHANNEL_NAME}_in_envelope.pb

export CORE_PEER_LOCALMSPID="WIPROMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/TWG/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/TWG/peerOrganizations/wipro.com/users/Admin@wipro.com/msp
export CORE_PEER_ADDRESS=localhost:9051
peer channel signconfigtx -f channel-artifacts-org/anchor_update_${CHANNEL_NAME}_in_envelope.pb
 

echo "Required Signature from All Orgs &  Update Channel " 
peer channel update -f channel-artifacts-org/anchor_update_${CHANNEL_NAME}_in_envelope.pb -c $CHANNEL_NAME -o localhost:7050 --tls --cafile $ORDERER_CA


echo "Joining Channel"
export CORE_PEER_LOCALMSPID="GOOGLEMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/TWG/peerOrganizations/google.com/peers/peer0.google.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/TWG/peerOrganizations/google.com/users/Admin@google.com/msp
export CORE_PEER_ADDRESS=localhost:11051
peer channel fetch 0 channel-artifacts/mychannel.block -o localhost:7050 -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
peer channel join -b channel-artifacts/mychannel.block