mkdir -p organizations/tlsca-wipro
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/tlsca-wipro/admin
fabric-ca-client enroll -u https://admin:adminpw@localhost:6054 --caname tlsca-wipro --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-wipro/ca-cert.pem --enrollment.profile tls  
 

# echo "Register User to run CA"
fabric-ca-client register -d --id.name rcaadmin --id.secret rcaadminpw -u https://localhost:6054  --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-wipro/ca-cert.pem --mspdir ${PWD}/organizations/tlsca-wipro/admin/msp

fabric-ca-client enroll -d -u https://rcaadmin:rcaadminpw@localhost:6054 --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-wipro/ca-cert.pem --enrollment.profile tls --csr.hosts 'localhost,*.wipro.com' --mspdir ${PWD}/organizations/tlsca-wipro/rcaadmin/msp      