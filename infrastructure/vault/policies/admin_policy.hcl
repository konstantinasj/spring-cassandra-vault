path "database/creds/cassandra-admin-role" {
    capabilities = ["read"]
}
path "secret/data/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}