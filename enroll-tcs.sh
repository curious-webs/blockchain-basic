mkdir -p organizations/peerOrganizations/tcs.com/
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/tcs.com/

fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-org1 --tls.certfiles ${PWD}/organizations/fabric-ca/tcs-ca/tls-cert.pem

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/tcs.com/msp/config.yaml


fabric-ca-client register --caname ca-org1 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/tcs-ca/tls-cert.pem


fabric-ca-client register --caname ca-org1 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/tcs-ca/tls-cert.pem

 fabric-ca-client register --caname ca-org1 --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/tcs-ca/tls-cert.pem

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/msp --csr.hosts peer0.tcs.com --tls.certfiles ${PWD}/organizations/fabric-ca/tcs-ca/tls-cert.pem

 fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls --enrollment.profile tls --csr.hosts peer0.tcs.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/tcs-ca/tls-cert.pem


 cp ${PWD}/organizations/peerOrganizations/tcs.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/msp/config.yaml



 cp ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/ca.crt

 cp ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/server.crt


 cp ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/server.key

 mkdir -p ${PWD}/organizations/peerOrganizations/tcs.com/msp/tlscacerts


 cp ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/tcs.com/msp/tlscacerts/ca.crt


 mkdir -p ${PWD}/organizations/peerOrganizations/tcs.com/tlsca

  cp ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/tcs.com/tlsca/tlsca.tcs.com-cert.pem

   mkdir -p ${PWD}/organizations/peerOrganizations/tcs.com/ca


   cp ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/tcs.com/ca/ca.tcs.com-cert.pem


   fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/tcs.com/users/User1@tcs.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/tcs-ca/tls-cert.pem

   cp ${PWD}/organizations/peerOrganizations/tcs.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/tcs.com/users/User1@tcs.com/msp/config.yaml

fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/tcs.com/users/Admin@tcs.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/tcs-ca/tls-cert.pem


cp ${PWD}/organizations/peerOrganizations/tcs.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/tcs.com/users/Admin@tcs.com/msp/config.yaml
