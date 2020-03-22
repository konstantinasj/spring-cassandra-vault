# Apache Cassandra
Apache Cassandra yra atviro kodo, paskirstyta, stulpeliais grįsta NoSQL duomenų bazės valdymo sistema, skirta apdoroti didelius duomenų kiekius, užtikrinant aukštą prieinamumą ir vieno nesėkmės taško (angl. *single point of failure*) nebuvimą. 

DBVS savybės:
- Kadangi DBVS yra paskirstyta, visi duomenys yra saugomi klasteryje, kuris yra sudarytas iš mazgų.
- Klasteris neturi išreikšto valdančio mazgo.
- Kiekvienas mazgas gali apdoroti tas užklausas, kurias jis yra pajėgus apdoroti.
- Siekiant užtikrinti prieinamumą, duomenys yra replikuojami tarp mazgų.
- Replikavimo faktorius nurodo keliuose skirtinguose mazguose bus saugomi tie patys duomenys.

## Konfigūracija
Cassandra DBVS konfigūracija yra saugoma `config/cassandra.yaml` faile. Realizuojant šią infrastruktūrą, buvo remtasi numatyta standartine konfigūracija, kuri buvo modifikuota pritaikant apsaugos mechanizmus.

Konfigūracijos nustatymai, kurie buvo modifikuoti:
- `authenticator` - Nurodo, ar DBVS naudotojai turi būti autentifikuojami. `PasswordAuthenticator` reikšmė nurodo, jog naudotojai bus autentifikuojami naudojant paskyros vardą ir slaptažodį, kurie bus saugomi `system_auth.credentials` lentelėje.
- `authorizer` - Nurodo, ar DBVS naudotojai turi būti autorizuojami. `CassandraAuthorizer` reikšmė nurodo, jog naudotojų autorizacija bus tikrinama pagal duomenis, esančius `system_auth.permissions` lentelėje.
- `client_encryption_options` - Nustatymų grupė, kuri nurodo kaip turi būti apsaugomas ryšio kanalas tarp DBVS ir jos kliento (angl. *encryption in flight*).
    - `enabled` - Nurodo, ar ryšys tarp DBVS ir kliento turi būti apsaugomas.
    - `optional` - Nurodo, ar apsaugotas ryšys tarp DBVS ir kliento yra privalomas, ar pasirinktinas.
    - `keystore` - Nurodoma JKS formato raktų saugykla, kurioje yra saugomi mazgo (DBVS) raktai. 
    - `keystore_password` - Nurodomas raktų saugyklos slaptažodis.
    - `require_client_auth` - Nurodoma, ar DBVS klientai turi būti autentifikuojami naudojant jų sertifikatus.
    - `truststore` - Nurodoma JKS formato raktų saugykla, kurioje yra saugomas CA (angl. *Certificate Authority*) sertifikatas. 
    - `truststore_password` - Nurodomas raktų saugyklos slaptažodis. 

## Diegimas
Šioje infrastruktūroje Cassandra klasteris yra sudarytas iš vieno mazgo. To daryti realiose produkcinėse aplinkose griežtai nerekomenduojama.

Cassandra DBVS diegimo metu yra vykdomas `config\setup.sh` scenarijus. Šis scenarijus:
- Sukuria naują administratoriaus paskyrą, kurios prisijungimo duomenys yra nurodomi `.env` faile: *CASSANDRA_USERNAME* ir *CASSANDRA_PASSWORD*.
- Prisijungus su naujai sukurta administratoriaus paskyra, įvykdo `config\setup-data.cql` faile esančias CQL užklausas: sukuria "KEYSPACE", lentelę ir ją užpildo pavyzdiniais duomenimis.
- Pakeičia standarinio `cassandra` naudotojo slaptažodį, kuris yra nurodomas *DEFAULT_CASSANDRA_PASSWORD* kintamajame ir šiam naudotojui atima super naudotojo teises.