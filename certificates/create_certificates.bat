@ECHO OFF

set CA_KEY_PASS=changeyourdefaults
set NODE1_KEY_PASS=changeyourdefaults
set CLIENT1_KEY_PASS=changeyourdefaults
set VAULT_KEY_PASS=changeyourdefaults

:: Certificate authority
mkdir ca
del /s /q ca\*
cd ca
openssl req -config ../ca_cert.conf -new -x509 -keyout ca.key.pem -out ca.cer.pem -days 365 -passout pass:%CA_KEY_PASS%
keytool -alias CA  -keystore ca.truststore.jks -importcert -file ca.cer.pem -keypass %CA_KEY_PASS% -storepass %CA_KEY_PASS% -noprompt
cd ..

:: Node1 - Cassandra
mkdir node1
del /s /q node1\*
cd  node1
keytool -genkeypair -keyalg RSA -alias node1 -keystore node1.keystore.jks -keypass %NODE1_KEY_PASS% -storepass %NODE1_KEY_PASS% -validity 365 -keysize 2048 -dname "CN=node1, OU=IF, O=KTU, L=Kaunas, C=Lithuania"
keytool -alias node1 -keystore node1.keystore.jks -certreq -file node1.csr -keypass %NODE1_KEY_PASS% -storepass %NODE1_KEY_PASS%
openssl x509 -req -CA ../ca/ca.cer.pem -CAkey ../ca/ca.key.pem -in node1.csr -out node1.cer.signed -days 365 -CAcreateserial -passin pass:%CA_KEY_PASS%
keytool -alias CA -keystore node1.keystore.jks -import -file ../ca/ca.cer.pem -noprompt -keypass %NODE1_KEY_PASS% -storepass %NODE1_KEY_PASS%
keytool -alias node1 -keystore node1.keystore.jks -import -file node1.cer.signed -keypass %NODE1_KEY_PASS% -storepass %NODE1_KEY_PASS%

del .srl
del node1.cer.signed
del node1.csr
cd ..

:: Client1 - Spring Boot application
mkdir client1
del /s /q client1\*
cd  client1
keytool -genkeypair -keyalg RSA -alias client1 -keystore client1.keystore.jks -keypass %CLIENT1_KEY_PASS% -storepass %CLIENT1_KEY_PASS% -validity 365 -keysize 2048 -dname "CN=client1, OU=KTU, O=None, L=Kaunas, C=Lithuania"
keytool -alias client1 -keystore client1.keystore.jks -certreq -file client1.csr -keypass %CLIENT1_KEY_PASS% -storepass %CLIENT1_KEY_PASS%
openssl x509 -req -CA ../ca/ca.cer.pem -CAkey ../ca/ca.key.pem -in client1.csr -out client1.cer.signed -days 365 -CAcreateserial -passin pass:%CA_KEY_PASS%
keytool -alias CA -keystore client1.keystore.jks -import -file ../ca/ca.cer.pem -noprompt -keypass %CLIENT1_KEY_PASS% -storepass %CLIENT1_KEY_PASS%
keytool -alias client1 -keystore client1.keystore.jks -import -file client1.cer.signed -keypass %CLIENT1_KEY_PASS% -storepass %CLIENT1_KEY_PASS%

del .srl
del client1.cer.signed
del client1.csr
cd ..

:: Vault
mkdir vault
del /s /q vault\*
cd  vault
openssl req -config ../vault_cert.conf -new -newkey rsa:2048 -nodes -keyout vault.key -out vault.csr -extensions req_ext -passout pass:%VAULT_KEY_PASS%
openssl x509 -req -CA ../ca/ca.cer.pem -CAkey ../ca/ca.key.pem -in vault.csr -out vault.crt -days 365 -CAcreateserial -passin pass:%CA_KEY_PASS% -extensions req_ext -extfile ../vault_cert.conf

del .srl
del vault.csr
cd ..

ECHO Certificates were created successfully