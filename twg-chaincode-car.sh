export FABRIC_CFG_PATH=../config
export CHANNEL_NAME="mychannel"
export ORDERER_CA=$PWD/TWG/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem

# echo
echo "Package Chain code" 
peer lifecycle chaincode package car.tar.gz --path /mnt/c/blockchainv22/fabric-samples/atcc --lang golang --label car_v1.0  

  
echo "Install on TCS per"
export CORE_PEER_TLS_ENABLED="true"             
export CORE_PEER_LOCALMSPID="TCSMSP" 
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/TWG/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/TWG/peerOrganizations/tcs.com/users/Admin@tcs.com/msp
export CORE_PEER_ADDRESS=localhost:7051
peer lifecycle chaincode install car.tar.gz
 


echo
echo "Install on WIPRO peer"
export CORE_PEER_TLS_ENABLED="true"
export CORE_PEER_LOCALMSPID="WIPROMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/TWG/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/TWG/peerOrganizations/wipro.com/users/Admin@wipro.com/msp
export CORE_PEER_ADDRESS=localhost:9051
peer lifecycle chaincode install car.tar.gz

# echo
# echo "Install on GOOGLE peer"
# export CORE_PEER_TLS_ENABLED="true"
# export CORE_PEER_LOCALMSPID="GOOGLEMSP"
# export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/TWG/peerOrganizations/google.com/peers/peer0.google.com/tls/ca.crt
# export CORE_PEER_MSPCONFIGPATH=${PWD}/TWG/peerOrganizations/google.com/users/Admin@google.com/msp
# export CORE_PEER_ADDRESS=localhost:11051
# peer lifecycle chaincode install car.tar.gz

echo "Listing Installed ChainCode on peer"
peer lifecycle chaincode queryinstalled    



# # Package ID: basic_v1.0:f42d56ded276f42740610b1ae8141c6125d4535e99753ca8148b9b23ba8ae681, Label: basic_v1.0




# echo "Approve chaincode on TCS Peer"
# export CORE_PEER_TLS_ENABLED="true"
# export CORE_PEER_LOCALMSPID="TCSMSP" 
# export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/TWG/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/ca.crt
# export CORE_PEER_MSPCONFIGPATH=${PWD}/TWG/peerOrganizations/tcs.com/users/Admin@tcs.com/msp
# export CORE_PEER_ADDRESS=localhost:7051
# peer lifecycle chaincode approveformyorg -o localhost:7050 --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name basic --version v1.0 --package-id  basic_v1.0:f42d56ded276f42740610b1ae8141c6125d4535e99753ca8148b9b23ba8ae681 --sequence 1

# # echo
# export CORE_PEER_TLS_ENABLED="true"
# export CORE_PEER_LOCALMSPID="WIPROMSP"
# export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/TWG/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/ca.crt
# export CORE_PEER_MSPCONFIGPATH=${PWD}/TWG/peerOrganizations/wipro.com/users/Admin@wipro.com/msp
# export CORE_PEER_ADDRESS=localhost:9051
# echo "Approve chaincode on WIPRO per"
# peer lifecycle chaincode approveformyorg -o localhost:7050  --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name basic --version v1.0 --package-id  basic_v1.0:f42d56ded276f42740610b1ae8141c6125d4535e99753ca8148b9b23ba8ae681 --sequence 1  

# export CORE_PEER_TLS_ENABLED="true"
# export CORE_PEER_LOCALMSPID="GOOGLEMSP"
# export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/TWG/peerOrganizations/google.com/peers/peer0.google.com/tls/ca.crt
# export CORE_PEER_MSPCONFIGPATH=${PWD}/TWG/peerOrganizations/google.com/users/Admin@google.com/msp
# export CORE_PEER_ADDRESS=localhost:11051
# echo "Approve chaincode on GOOGLE per"
# peer lifecycle chaincode approveformyorg -o localhost:7050  --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name basic --version v1.0 --package-id  basic_v1.0:f42d56ded276f42740610b1ae8141c6125d4535e99753ca8148b9b23ba8ae681 --sequence 1




# echo
# echo "Checking chaincode approvasl"
# peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME --name basic --version v1.0 --sequence 1

# echo

# export CORE_PEER_TLS_ENABLED="true"
# export CORE_PEER_LOCALMSPID="TCSMSP" 
# export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/TWG/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/ca.crt
# export CORE_PEER_MSPCONFIGPATH=${PWD}/TWG/peerOrganizations/tcs.com/users/Admin@tcs.com/msp
# export CORE_PEER_ADDRESS=localhost:7051

# echo
# echo "Commit chaincode - can be committed by any one of org"
# peer lifecycle chaincode commit -o localhost:7050 --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name basic  --version v1.0 --sequence 1 --peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/TWG/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/TWG/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/ca.crt  --peerAddresses localhost:11051 --tlsRootCertFiles ${PWD}/TWG/peerOrganizations/google.com/peers/peer0.google.com/tls/ca.crt 

 