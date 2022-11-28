# mkdir -p organizations/peerOrganizations/wipro.com/
# export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/wipro.com/



# fabric-ca-client enroll -u https://admin:adminpw@localhost:6055 --caname ca-wipro --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-wipro/ca-cert.pem 

# echo 'NodeOUs:
#   Enable: true
#   ClientOUIdentifier:
#     Certificate: cacerts/localhost-6055-ca-wipro.pem
#     OrganizationalUnitIdentifier: client
#   PeerOUIdentifier:
#     Certificate: cacerts/localhost-6055-ca-wipro.pem
#     OrganizationalUnitIdentifier: peer
#   AdminOUIdentifier:
#     Certificate: cacerts/localhost-6055-ca-wipro.pem
#     OrganizationalUnitIdentifier: admin
#   OrdererOUIdentifier:
#     Certificate: cacerts/localhost-6055-ca-wipro.pem
#     OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/wipro.com/msp/config.yaml
 

# echo
# echo "Register Peer with Identity/org CA"
# fabric-ca-client register --caname ca-wipro -u https://localhost:6055 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-wipro/ca-cert.pem --mspdir ${PWD}/organizations/peerOrganizations/wipro.com/msp 
# fabric-ca-client enroll -u https://peer0:peer0pw@localhost:6055 --caname ca-wipro -M ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/msp --csr.hosts peer0.wipro.com --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-wipro/ca-cert.pem

# echo
# echo "Register Peer with TLS CA"
# fabric-ca-client register --caname tlsca-wipro -u https://localhost:6054 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-wipro/ca-cert.pem --mspdir ${PWD}/organizations/tlsca-wipro/admin/msp  
# fabric-ca-client enroll -u https://peer0:peer0pw@localhost:6054 --caname tlsca-wipro -M ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls --enrollment.profile tls --csr.hosts peer0.wipro.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-wipro/ca-cert.pem

# echo
# echo "Register User"
# fabric-ca-client register --caname ca-wipro --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-wipro/ca-cert.pem --mspdir=${PWD}/organizations/peerOrganizations/wipro.com/msp
# fabric-ca-client enroll -u https://user1:user1pw@localhost:6055 --caname ca-wipro -M ${PWD}/organizations/peerOrganizations/wipro.com/users/User1@wipro.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-wipro/ca-cert.pem 


# echo
# echo "Register Admin"
# fabric-ca-client register --caname ca-wipro --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-wipro/ca-cert.pem --mspdir=${PWD}/organizations/peerOrganizations/wipro.com/msp --id.attrs 'hf.Registrar.Roles=client,hf.Registrar.Attributes=*,hf.Revoker=true,hf.GenCRL=true,admin=true:ecert,abac.init=true:ecert'
# fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:6055 --caname ca-wipro -M ${PWD}/organizations/peerOrganizations/wipro.com/users/Admin@wipro.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-wipro/ca-cert.pem

# echo
# echo "Copy config.yaml to each MSP"
# cp ${PWD}/organizations/peerOrganizations/wipro.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/msp/config.yaml
# cp ${PWD}/organizations/peerOrganizations/wipro.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/wipro.com/users/User1@wipro.com/msp/config.yaml
# cp ${PWD}/organizations/peerOrganizations/wipro.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/wipro.com/users/Admin@wipro.com/msp/config.yaml


# echo
echo "Copy TLS certs outside"
# cp ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/ca.crt
# cp ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/server.crt
# cp ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/server.key


# echo
# echo "Copy TLSCA certs to Org MSP"
# mkdir -p ${PWD}/organizations/peerOrganizations/wipro.com/msp/tlscacerts
# cp ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/wipro.com/msp/tlscacerts/ca.crt


# echo
# echo "Main tlsca" 
# mkdir -p ${PWD}/organizations/peerOrganizations/wipro.com/tlsca
# cp ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/wipro.com/tlsca/tlsca.wipro.com-cert.pem

# mkdir -p ${PWD}/organizations/peerOrganizations/wipro.com/ca
# cp ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/wipro.com/ca/ca.wipro.com-cert.pem