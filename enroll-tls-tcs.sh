mkdir -p organizations/peerOrganizations/tcs.com/
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/tcs.com/
fabric-ca-client enroll -u https://admin:adminpw@localhost:7055 --caname ca-tcs --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-tcs/ca-cert.pem

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7055-ca-tcs.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7055-ca-tcs.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7055-ca-tcs.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7055-ca-tcs.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/tcs.com/msp/config.yaml


echo
echo "Register Peer with Identity CA"
fabric-ca-client register --caname ca-tcs -u https://localhost:7055 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-tcs/ca-cert.pem --mspdir=${PWD}/organizations/peerOrganizations/tcs.com/msp
fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7055 --caname ca-tcs -M ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/msp --csr.hosts peer0.tcs.com --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-tcs/ca-cert.pem

echo
echo "Register Peer with TLS CA"
fabric-ca-client register --caname tlsca-tcs -u https://localhost:7054 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-tcs/ca-cert.pem --mspdir ${PWD}/organizations/tlsca-tcs/admin2/msp
fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname tlsca-tcs -M ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls --enrollment.profile tls --csr.hosts peer0.tcs.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-tcs/ca-cert.pem

echo
echo "Register User"
fabric-ca-client register --caname ca-tcs --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-tcs/ca-cert.pem --mspdir=${PWD}/organizations/peerOrganizations/tcs.com/msp
fabric-ca-client enroll -u https://user1:user1pw@localhost:7055 --caname ca-tcs -M ${PWD}/organizations/peerOrganizations/tcs.com/users/User1@tcs.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-tcs/ca-cert.pem


echo
echo "Register Admin"
fabric-ca-client register --caname ca-tcs --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-tcs/ca-cert.pem --mspdir=${PWD}/organizations/peerOrganizations/tcs.com/msp --id.attrs 'hf.Registrar.Roles=client,hf.Registrar.Attributes=*,hf.Revoker=true,hf.GenCRL=true,admin=true:ecert,abac.init=true:ecert'
fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:7055 --caname ca-tcs -M ${PWD}/organizations/peerOrganizations/tcs.com/users/Admin@tcs.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-tcs/ca-cert.pem

echo
echo "Copy config.yaml to each MSP"
cp ${PWD}/organizations/peerOrganizations/tcs.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/msp/config.yaml
cp ${PWD}/organizations/peerOrganizations/tcs.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/tcs.com/users/User1@tcs.com/msp/config.yaml
cp ${PWD}/organizations/peerOrganizations/tcs.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/tcs.com/users/Admin@tcs.com/msp/config.yaml


echo
echo "Copy TLS certs outside"
cp ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/ca.crt
cp ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/server.crt
cp ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/server.key


echo
echo "Copy TLSCA certs to Org MSP"
mkdir -p ${PWD}/organizations/peerOrganizations/tcs.com/msp/tlscacerts
cp ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/tcs.com/msp/tlscacerts/ca.crt


echo
echo "Main tlsca" 
mkdir -p ${PWD}/organizations/peerOrganizations/tcs.com/tlsca
cp ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/tcs.com/tlsca/tlsca.tcs.com-cert.pem

mkdir -p ${PWD}/organizations/peerOrganizations/tcs.com/ca
cp ${PWD}/organizations/peerOrganizations/tcs.com/peers/peer0.tcs.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/tcs.com/ca/ca.tcs.com-cert.pem