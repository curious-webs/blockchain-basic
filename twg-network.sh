./dcln.sh
echo "Generating Certificates"
cryptogen generate --config=organizations/cryptogen/crypto-config-twg.yaml --output="TWG" 



echo "Creating System Block - Only need to create for orderer"  
echo "For MyChannel"
export FABRIC_CFG_PATH=${PWD}/configtx
export ORDERER_CA=${PWD}/TWG/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem 
configtxgen -outputBlock genesis_block.block -profile TWGOrdererGenesis  -channelID system-channel


echo "Docker Up"
docker compose -f docker/docker-compose-twg-net.yaml up -d

echo "Generate Channel.tx block for mychannel"
configtxgen -profile TWGChannel -outputCreateChannelTx ./channel-artifacts/mychannel.tx -channelID mychannel 

echo "Generate Channel.tx block for oneorg"
configtxgen -profile oneorgChannel -outputCreateChannelTx ./channel-artifacts/oneorg.tx -channelID oneorg 

echo "Create Channel - mychannel"
export FABRIC_CFG_PATH=../config
export CORE_PEER_LOCALMSPID="TCSMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/TWG/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/TWG/peerOrganizations/tcs.com/users/Admin@tcs.com/msp
export CORE_PEER_ADDRESS=localhost:7051
peer channel create -o localhost:7050 -c mychannel  -f ./channel-artifacts/mychannel.tx --outputBlock ./channel-artifacts/mychannel.block --tls true --cafile $ORDERER_CA
echo "Create Channel - oneorg"
export FABRIC_CFG_PATH=../config
export CORE_PEER_LOCALMSPID="TCSMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/TWG/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/TWG/peerOrganizations/tcs.com/users/Admin@tcs.com/msp
export CORE_PEER_ADDRESS=localhost:7051
peer channel create -o localhost:7050 -c oneorg  -f ./channel-artifacts/oneorg.tx --outputBlock ./channel-artifacts/oneorg.block --tls true --cafile $ORDERER_CA
		
echo "Join Channel mychannel -- TCS PEER"
export CORE_PEER_TLS_ENABLED=true
peer channel join -b ./channel-artifacts/mychannel.block    
echo "Join Channel oneorg -- TCS PEER"
peer channel join -b ./channel-artifacts/oneorg.block     


echo "Join Channel mychannel -- WIPRO PEER"
export FABRIC_CFG_PATH=../config
export CORE_PEER_LOCALMSPID="WIPROMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/TWG/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/TWG/peerOrganizations/wipro.com/users/Admin@wipro.com/msp
export CORE_PEER_ADDRESS=localhost:9051
peer channel join -b ./channel-artifacts/mychannel.block 



