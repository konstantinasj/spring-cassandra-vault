# Spring Boot klientas

Tai yra paprasta Spring Boot aplikacija, kuri prisijungia prie Cassandra duomenų bazės, iš `songs` lentelės paima visas joje esančias dainas ir jas JSON formatu pateikia per `/api/songs` REST prieigos tašką.

Ši taikomoji aplikacija naudoja [`Spring Cloud Vault`](https://cloud.spring.io/spring-cloud-vault/reference/html/) sprendimą, kuris leidžia automatiškai integruoti Vault panaudojimą su Spring Boot aplikacija.
Taikomajai aplikacijai yra perduodamas Vault žetonas bei nurodoma rolė, kuri nurodo kokiu keliu reikia ieškoti prisijungimo prie Cassandra DBVS paslapties. Vault žetonas yra perduodamas per `VAULT_TOKEN` aplinkos kintamąjį, o rolė nurodoma per `CASSANDRA_ROLE` aplinkos kintamąjį.

Paleidžiant Spring Boot klientą, pirmiausiai yra kreipiamasi į Vault saugyklą su žetonu. Šis žetonas yra iškeičiamas į prisijungimo duomenis prie Cassandra DBVS. Klientas, gavęs šiuos duomenis, juos naudoja prisijungimui prie pačios Cassandra DBVS.

## Konfigūracija

### Aplinkos kintamieji
Paleidžiant aplikaciją, turi būti nurodyti šie aplinkos kintamieji:
- `VAULT_TOKEN`. Pvz. `s.aaaaaaaaaueaaaaaaaaaaaa`
- `KEY_STORE`. Pvz. `classpath:client1.keystore.jks`
- `KEY_STORE_PASSWORD`. Pvz. `changeyourdefaults`
- `KEY_ALIAS`. Pvz. `client1`
- `KEY_PASSWORD`. Pvz. `changeyourdefaults`
- `KEY_STORE_TYPE`. Pvz. `JKS`
- `SSL_ENABLED`. Pvz. `true`
- `CASSANDRA_ROLE`. Pvz. `cassandra-user-role`

### VM nustatymai
Paleidžiant aplikaciją, turi būti nurodyti šie virtualios mašinos nustatymai:
- `-Djavax.net.ssl.trustStore=\kelias\iki\ca.truststore.jks`
- `-Djavax.net.ssl.trustStorePassword=cassandra`
- `-Dspring.cloud.vault.ssl.trust-store=classpath:ca.truststore.jks`
- `-Dspring.cloud.vault.ssl.trust-store-password=cassandra`

Pastaba: Tai yra tik pavyzdinės reikšmės. Atitinkamai nurodykite savas reikšmes.

## Paleidimas
- Patogiausia aplikaciją kūrimo metu leisti naudojant IntelliJ IDEA integruotą kūrimo aplinką ir pasirenkant `SpringCassandraVaultApplication` kaip pagrindinę klasę.
- Aplikacija gali būti paleidžiama naudojant `Spring Boot Maven` įskiepį vykdant komandą `./mvnw spring-boot:run`.
- Aplikacija gali būti supakuojama vykdant komandą `./mvnw package` ir leidžiama vykdant komandą `java -jar target/client1.jar`.

### SSL derinimo režimas
- Pridėkite `-Djavax.net.debug=ssl` prie VM nustatymų