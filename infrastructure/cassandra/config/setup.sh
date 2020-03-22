#!/usr/bin/env bash

echo "[*] Executing user creation script..."
echo "CREATE USER $CASSANDRA_USERNAME WITH PASSWORD '$CASSANDRA_PASSWORD' SUPERUSER;" | cqlsh --ssl -u cassandra -p cassandra localhost

echo "[*] Executing database creation script..."
cqlsh --ssl -f /opt/setup-data.cql -u $CASSANDRA_USERNAME -p $CASSANDRA_PASSWORD localhost

echo "[*] Restricting default user..."
echo "ALTER USER cassandra WITH PASSWORD '$DEFAULT_CASSANDRA_PASSWORD' NOSUPERUSER;" | cqlsh --ssl -u $CASSANDRA_USERNAME -p $CASSANDRA_PASSWORD localhost

echo "[*] Cassandra was successfully configured."