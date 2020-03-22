# Apache Cassandra diegimas Docker aplinkoje ir integravimas su taikomąja aplikacija naudojant HashiCorp Vault įrankį

## Sprendžiama problema

Paslapčių (angl. *secrets*) rotacija yra svarbi ne tik duomenų bazių, bet ir visos sistemų infrastruktūros saugos sritis. Dažnai įdiegus tam tikrus infrastruktūros komponentus ir sukūrus atitinkamas paskyras ar API raktus, jie nėra keičiami ilgą laiką, o jei ir yra keičiami, tai yra atliekama rankiniu būdu. Taikomosios aplikacijos naudoja autentifikacijos duomenis, kurie yra naudojami prisijungimui prie įvairių API ar duomenų bazių. Visgi egzistuoja rizika, jog įsilaužus į taikomąją programą, iš jos gali būti pavogti autentifikacijos duomenys, kurie gali būti panaudoti prisijungimui prie kritinių sistemų.

Šios problemos sprendimui yra naudojami tokie įrankiai kaip HashiCorp Vault. Ši saugykla yra skirta saugoti autentifikacijos duomenis, API raktus, sertifikatus ir kitą jautrią informaciją. Atitinkamai klientai gali kreiptis į saugyklą ir gauti jiems reikalaingus duomenis. Ši saugykla taip pat palaiko dinaminių paslapčių kūrimą - t.y. Vault sistema gali sukurti tam tikrus autentifikacijos duomenis, kurie bus validūs tik tam tikrą laiko periodą. Dinaminių paslapčių pavyzdžiai - IAM rolė, SSH raktas ar duomenų bazės paskyra. Tad jei toks principas būtų panaudotas suteikiant prisijungimo prie duomenų bazės duomenis taikomosioms aplikacijoms, įsilaužus į taikomosios aplikacijos serverį, iš jo išgauti duomenų bazės prisijungimo duomenys būtų validūs tik tam tikrą laiką, kadangi būtų automatiškai rotuojami ir nebevalidūs po tam tikro laiko.

Vault dinaminių paslapčių veikimo principas:

![Vault dinaminių paslapčių veikimo principas](https://www.datocms-assets.com/2885/1519774324-dynamic-secret-img-001.jpeg)

Taip pat ši saugykla yra naudojama ir programuotojų, kurie nori gauti prisijungimo duomenis prie testavimo aplinkų duomenų bazių. Programuotojai gali naudoti savo AD prisijungimo duomenis ir jiems yra sukuriamas naujas laikinas DBVS naudotojas. Kuomet darbuotojai išeina iš darbo arba nebedirba prie tam tikro projekto, jie nebegali gauti prisijungimo duomenų prie testavimo aplinkų, kadangi administratoriai atitinkamai pakeičia jų paskyros konfigūraciją.

## Darbe naudojami įrankiai

| Pavadinimas        | Versija      |
| ------------------ | ------------:|
| Docker for Windows | 18.05.0-ce   |
| HashiCorp Vault    | 1.3.2        |
| Consul             | 1.7.0        |
| Apache Cassandra   | 2.1.21       |
| OpenJDK            | 13.0.2       |
| Spring Boot        | 2.2.4        |
| OpenSSL            | 1.1.01       |


## Naudoti šaltiniai

### Cassandra konfigūracija
- https://hopding.com/cassandra-authentication-in-docker-container
- https://docs.datastax.com/en/archived/cassandra/3.0/cassandra/configuration/configCassandra_yaml.html
- https://digitalis.io/blog/simple-tips-securing-cassandra/
- https://www.instaclustr.com/apache-cassandra-security/
- https://www.guru99.com/cassandra-security.html
- https://docs.genesys.com/Documentation/GCB/latest/Deployment/CassandraSecurity
- https://blog.pythian.com/cassandra-3-9-security-feature-walk/
- https://www.slideshare.net/DataStax/securing-cassandra-for-compliance
- https://thelastpickle.com/blog/2015/09/30/hardening-cassandra-step-by-step-part-1-server-to-server.html
- http://cassandra.apache.org/doc/latest/operating/security.html

### Taikomosios aplikacijos ir Cassandra integravimas
- https://vocon-it.com/2016/12/08/cassandra-hello-world-example/
- https://medium.com/@aamine/spring-data-for-cassandra-a-complete-example-3c6f7f39fef9
- https://www.baeldung.com/spring-data-cassandra-tutorial
- https://www.codingame.com/playgrounds/13642/getting-started-with-spring-data-cassandra

### Vault
- https://www.vaultproject.io/docs/secrets/databases/cassandra/
- https://spring.io/blog/2016/08/15/managing-your-database-secrets-with-vault
- http://work.haufegroup.io/spring-cloud-config-and-vault/
- https://dzone.com/articles/managing-your-database-secrets-with-vault
- https://nomadproject.io/guides/integrations/vault-integration/
- http://work.haufegroup.io/spring-cloud-config-and-vault/
- https://www.vaultproject.io/docs/auth/userpass/
- https://www.vaultproject.io/docs/concepts/policies/
- https://learn.hashicorp.com/vault/getting-started/policies
- https://cloud.spring.io/spring-cloud-vault/reference/html/#vault.config.backends
- https://cloud.spring.io/spring-cloud-static/Edgware.SR6/multi/multi_vault.config.backends.database-backends.html
- https://www.marcolancini.it/2017/blog-vault/