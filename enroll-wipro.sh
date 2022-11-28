mkdir -p organizations/peerOrganizations/wipro.com/
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/wipro.com/

fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca-org2 --tls.certfiles ${PWD}/organizations/fabric-ca/wipro-ca/tls-cert.pem

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org1.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org1.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org1.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org1.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/wipro.com/msp/config.yaml


fabric-ca-client register --caname ca-org2 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/wipro-ca/tls-cert.pem


fabric-ca-client register --caname ca-org2 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/wipro-ca/tls-cert.pem

 fabric-ca-client register --caname ca-org2 --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/wipro-ca/tls-cert.pem

 fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/msp --csr.hosts peer0.wipro.com --tls.certfiles ${PWD}/organizations/fabric-ca/wipro-ca/tls-cert.pem


 cp ${PWD}/organizations/peerOrganizations/wipro.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/msp/config.yaml

 fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls --enrollment.profile tls --csr.hosts peer0.wipro.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/wipro-ca/tls-cert.pem


 cp ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/ca.crt

 cp ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/server.crt


 cp ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/server.key

 mkdir -p ${PWD}/organizations/peerOrganizations/wipro.com/msp/tlscacerts


 cp ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/wipro.com/msp/tlscacerts/ca.crt


 mkdir -p ${PWD}/organizations/peerOrganizations/wipro.com/tlsca

  cp ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/wipro.com/tlsca/tlsca.wipro.com-cert.pem

   mkdir -p ${PWD}/organizations/peerOrganizations/wipro.com/ca


   cp ${PWD}/organizations/peerOrganizations/wipro.com/peers/peer0.wipro.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/wipro.com/ca/ca.wipro.com-cert.pem


   fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/wipro.com/users/User1@wipro.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/wipro-ca/tls-cert.pem

   cp ${PWD}/organizations/peerOrganizations/wipro.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/wipro.com/users/User1@wipro.com/msp/config.yaml

fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/wipro.com/users/Admin@wipro.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/wipro-ca/tls-cert.pem


cp ${PWD}/organizations/peerOrganizations/wipro.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/wipro.com/users/Admin@wipro.com/msp/config.yaml
