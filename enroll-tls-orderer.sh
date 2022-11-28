mkdir -p organizations/ordererOrganizations/orderer.com/
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/orderer.com/



# fabric-ca-client enroll -u https://admin:adminpw@localhost:9055 --caname ca-orderer --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-orderer/ca-cert.pem 
 
# echo 'NodeOUs:  
#   Enable: true
#   ClientOUIdentifier:
#     Certificate: cacerts/localhost-9055-ca-orderer.pem
#     OrganizationalUnitIdentifier: client
#   PeerOUIdentifier:
#     Certificate: cacerts/localhost-9055-ca-orderer.pem
#     OrganizationalUnitIdentifier: peer
#   AdminOUIdentifier:
#     Certificate: cacerts/localhost-9055-ca-orderer.pem
#     OrganizationalUnitIdentifier: admin
#   OrdererOUIdentifier:
#     Certificate: cacerts/localhost-9055-ca-orderer.pem
#     OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/ordererOrganizations/orderer.com/msp/config.yaml
 

# echo
# echo "Register Peer with Identity/org CA"
# fabric-ca-client register --caname ca-orderer -u https://localhost:9055 --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-orderer/ca-cert.pem --mspdir ${PWD}/organizations/ordererOrganizations/orderer.com/msp 
# fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9055 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp --csr.hosts orderer.orderer.com --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-orderer/ca-cert.pem

# echo
# echo "Register Peer with TLS CA"
# fabric-ca-client register --caname tlsca-orderer -u https://localhost:9054 --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-orderer/ca-cert.pem --mspdir ${PWD}/organizations/tlsca-orderer/admin/msp  
# fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname tlsca-orderer -M ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls --enrollment.profile tls --csr.hosts orderer.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-orderer/ca-cert.pem

# echo
# echo "Register User"
# fabric-ca-client register --caname ca-orderer --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-orderer/ca-cert.pem --mspdir=${PWD}/organizations/ordererOrganizations/orderer.com/msp
# fabric-ca-client enroll -u https://user1:user1pw@localhost:9055 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/orderer.com/users/User1@orderer.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-orderer/ca-cert.pem 


# echo
# echo "Register Admin"
# fabric-ca-client register --caname ca-orderer --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-orderer/ca-cert.pem --mspdir=${PWD}/organizations/ordererOrganizations/orderer.com/msp --id.attrs 'hf.Registrar.Roles=client,hf.Registrar.Attributes=*,hf.Revoker=true,hf.GenCRL=true,admin=true:ecert,abac.init=true:ecert'
# fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:9055 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/orderer.com/users/Admin@orderer.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-orderer/ca-cert.pem

# echo
# echo "Copy config.yaml to each MSP"
# cp ${PWD}/organizations/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/config.yaml
# cp ${PWD}/organizations/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/orderer.com/users/User1@orderer.com/msp/config.yaml
# cp ${PWD}/organizations/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/orderer.com/users/Admin@orderer.com/msp/config.yaml


# echo
# echo "Copy TLS certs outside"
# cp ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/ca.crt
# cp ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/server.crt
# cp ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/server.key


# echo
# echo "Copy TLSCA certs to Org MSP"
# mkdir -p ${PWD}/organizations/ordererOrganizations/orderer.com/msp/tlscacerts
# cp ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer.com/msp/tlscacerts/ca.crt


# echo
# echo "Main tlsca" 
# mkdir -p ${PWD}/organizations/ordererOrganizations/orderer.com/tlsca
# cp ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer.com/tlsca/tlsca.orderer.com-cert.pem

# mkdir -p ${PWD}/organizations/ordererOrganizations/orderer.com/ca
# cp ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/cacerts/* ${PWD}/organizations/ordererOrganizations/orderer.com/ca/ca.orderer.com-cert.pem