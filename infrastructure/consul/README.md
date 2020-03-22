# HashiCorp Consul

Vault naudoja Consul duomenų laikymui (angl. [`Storage Backend`](https://www.vaultproject.io/docs/configuration/storage/consul/)). Consul yra geras pasirinkimas, kadangi teikia aukštą prieinamumą bei yra oficialiai palaikomas HashiCorp kompanijos.

## Konfigūracija

`config/consul-config.json` faile yra nurodoma Consul konfigūracija. Konfigūracijoje yra nurodoma:
- `datacenter` - Nurodo, kokiame duomenų centre šis agentas veikia.
- `data_dir` - Nurodo, kurioje vietoje agentas turi saugoti savo duomenis.
- `log_level` - Nurodo auditavimo lygmenį.
- `ui` - Nurodo, ar turi būti teikiama grafinė vartotojo sąsaja.
- `ports.dns` - Nurodo DNS prievadą.