# mkdir -p organizations/tlsca-tcs
# export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/tlsca-tcs/admin2
# fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname tlsca-tcs --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-tcs/ca-cert.pem --enrollment.profile tls


echo "Register User to run CA"
fabric-ca-client register -d --id.name rcaadmin --id.secret rcaadminpw -u https://localhost:7054  --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-tcs/ca-cert.pem --mspdir ${PWD}/organizations/tlsca-tcs/admin2/msp

fabric-ca-client enroll -d -u https://rcaadmin:rcaadminpw@localhost:7054 --tls.certfiles ${PWD}/organizations/fabric-ca/tlsca-tcs/ca-cert.pem --enrollment.profile tls --csr.hosts 'localhost,*.tcs.com' --mspdir ${PWD}/organizations/tlsca-tcs/rcaadmin/msp