# Sertifikatai

Sertifikatai yra naudojami sukurti šifruotus kanalus tarp šių infrastruktūros komponentų:
- Taikomoji aplikacija ⬌ Vault
- Vault ⬌ Cassandra
- Taikomoji aplikacija ⬌ Cassandra
- Naršyklė ⬌ Taikomoji aplikacija

## Naudojimas
- Sertifikatai yra sukuriami paleidžiant `create_certificates.bat` scenarijų.
- Sertifikatai yra nukopijuojami į atitinkamų infrastruktūros komponentų direktorijas paleidžiant `copy_certificates.bat` scenarijų.