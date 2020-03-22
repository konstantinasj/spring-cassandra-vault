# Demonstracija

## Infrastruktūra
Pirmiausiai `infrastructure/.env-sample` pagrindu yra sukuriamas `infrastructure/.env` failas su globaliais kintamaisiais. Pvz.:
```
CASSANDRA_USERNAME=ktu
CASSANDRA_PASSWORD=ktu
DEFAULT_CASSANDRA_PASSWORD=ktu
VAULT_ADMIN_USERNAME=vault
VAULT_ADMIN_PASSWORD=vault
```

Tuomet infrastruktūra yra sukuriama paleidžiant komandą `docker-compose up -d --build`.

![Infrastruktūros sukūrimas](./images/demo/infrastructure_creation.png)

Sukūrus infrastruktūrą, Cassandra DBVS yra konfigūruojama vykdant komandą `docker exec -it infrastructure_cassandra_1 bash /opt/setup.sh`.

![Cassandra DBVS konfigūravimas](./images/demo/cassandra_configuration.png)

Tuomet Vault yra konfigūruojamas vykdant komandą `docker exec -it infrastructure_vault_1 bash /vault/config/setup.sh`.

![Vault konfigūravimas](./images/demo/vault_configuration.png)

Vault žetonas, skirtas klientui (taikomajai aplikacijai), yra gaunamas vykdant komandą `docker exec -it infrastructure_vault_1 cat /vault/app-token.txt`.

![Kliento Vault žetonas](./images/demo/client_token.png)

## Klientas
Taikomoji Spring Boot kliento aplikacija yra leidžiama naudojant IntelliJ IDEA integruotą kūrimo aplinką.

Aplikacijos globalieji kintamieji:

![Aplikacijos globalieji kintamieji](./images/demo/client_env_variables.png)

Aplikacijos VM nustatymai:

![Aplikacijos VM nustatymai](./images/demo/client_vm_options.png)

Paleidus aplikaciją, jos sisteminiame žurnale yra matoma, jog aplikacija prisijungė prie Vault, nuskaitė `cassandra-user-role` paslapties reikšmę ir gavo dinaminį prisijungimą, su kuriuo sėkmingai prisijungė prie Cassandra DBVS.

![Prisijungimas prie Vault ir Cassandra](./images/demo/vault_cassandra_connection.png)

Pasileidus HTTP serveriui, galima kreiptis į API prieigos tašką, kuris nuskaitys visas dainas iš `songs` lentelės ir pateiks jas JSON formatu.

![API prieigos taško atsakymas](./images/demo/client_endpoint_response.png)

Prisijungus prie Cassandra DBVS, naudotojų sąraše galima matyti laikinus DBVS vartotojus, kuriuos sukūrė Vault.

![Cassandra naudotojų sąrašas](./images/demo/cassandra_user_list.png)