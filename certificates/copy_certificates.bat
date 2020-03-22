@ECHO OFF

copy "ca\ca.truststore.jks" "..\infrastructure\cassandra\ssl"
copy "node1\node1.keystore.jks" "..\infrastructure\cassandra\ssl"
copy "ca\ca.cer.pem" "..\infrastructure\cassandra\ssl"

copy "vault\vault.crt" "..\infrastructure\vault\ssl"
copy "vault\vault.key" "..\infrastructure\vault\ssl"

copy "ca\ca.truststore.jks" "..\infrastructure\client\src\main\resources"
copy "client1\client1.keystore.jks" "..\infrastructure\client\src\main\resources"

ECHO Certificates were copied successfully