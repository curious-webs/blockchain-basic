echo "Enrolling the CA admin"
  mkdir -p organizations/ordererOrganizations/orderer.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/orderer.com

  
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles ${PWD}/organizations/fabric-ca/orderer-ca/tls-cert.pem


  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/ordererOrganizations/orderer.com/msp/config.yaml

 echo "Registering orderer"

  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/orderer-ca/tls-cert.pem


 echo "Registering the orderer admin"

  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/orderer-ca/tls-cert.pem


 echo "Generating the orderer msp"

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp --csr.hosts orderer.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/orderer-ca/tls-cert.pem


  cp ${PWD}/organizations/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/config.yaml

 echo "Generating the orderer-tls certificates"

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls --enrollment.profile tls --csr.hosts orderer.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/orderer-ca/tls-cert.pem


  cp ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/server.key

  mkdir -p ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem

  mkdir -p ${PWD}/organizations/ordererOrganizations/orderer.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem

 echo "Generating the admin msp"

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/orderer.com/users/Admin@orderer.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/orderer-ca/tls-cert.pem

 
  cp ${PWD}/organizations/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/orderer.com/users/Admin@orderer.com/msp/config.yaml
