mkdir -p organizations/tlsca-orderer
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/tlsca-orderer/admin
fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname tlsca-orderer --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-orderer/ca-cert.pem --enrollment.profile tls  
 

# echo "Register User to run CA"
fabric-ca-client register -d --id.name rcaadmin --id.secret rcaadminpw -u https://localhost:9054  --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-orderer/ca-cert.pem --mspdir ${PWD}/organizations/tlsca-orderer/admin/msp

fabric-ca-client enroll -d -u https://rcaadmin:rcaadminpw@localhost:9054 --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-orderer/ca-cert.pem --enrollment.profile tls --csr.hosts 'localhost,*.orderer.com' --mspdir ${PWD}/organizations/tlsca-orderer/rcaadmin/msp      