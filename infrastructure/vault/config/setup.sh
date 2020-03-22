#!/usr/bin/env bash

## Initialize Vault
echo "[*] Initializing vault..."
vault operator init -address=${VAULT_ADDR} > /vault/keys.txt
export VAULT_TOKEN=$(grep 'Initial Root Token:' /vault/keys.txt | awk '{print substr($NF, 1, length($NF))}')

## Unseal Vault
echo "[*] Unsealing Vault..."
vault operator unseal -address=${VAULT_ADDR} $(grep 'Key 1:' /vault/keys.txt | awk '{print $NF}')
vault operator unseal -address=${VAULT_ADDR} $(grep 'Key 2:' /vault/keys.txt | awk '{print $NF}')
vault operator unseal -address=${VAULT_ADDR} $(grep 'Key 3:' /vault/keys.txt | awk '{print $NF}')

## Root authentication
echo "[*] Authenticating..."
echo ${VAULT_TOKEN} | vault login -

## Create backup token
echo "[*] Creating backup token..."
vault token create -display-name="backup_token" | awk '/token/{i++}i==1' | awk '{print "backup_token: " $2}' >> /vault/backup-token.txt

## Create policies
echo "[*] Creating policies..."
vault policy write admin /vault/config/admin_policy.hcl
vault policy write db-user /vault/config/db_user_policy.hcl
vault policy write client1 /vault/config/client1_policy.hcl

## Create admin user
echo "[*] Creating admin user..."
vault auth enable userpass 
vault write auth/userpass/users/$VAULT_ADMIN_USERNAME password=$VAULT_ADMIN_PASSWORD policies=admin

## Create token for application
echo "[*] Creating application token..."
vault token create -display-name="app_token" -policy=db-user -policy=client1 | awk '/token/{i++}i==1' | awk '{print "app_token: " $2}' >> /vault/app-token.txt

## Enable dynamic database secrets backend
echo "[*] Enabling dynamic secrets backend..."
vault secrets enable database

## Enable Cassandra database plugin
echo "[*] Enabling Cassandra database plugin..."
vault write database/config/ktu-cassandra-database \
    plugin_name="cassandra-database-plugin" \
    hosts=cassandra \
    protocol_version=3 \
    username=${CASSANDRA_USERNAME} \
    password=${CASSANDRA_PASSWORD} \
    allowed_roles=cassandra-user-role,cassandra-admin-role \
    tls=true \
    skip_verification=true

## Create Cassandra admin role
echo "[*] Creating Cassandra admin role..."
vault write database/roles/cassandra-admin-role \
    db_name=ktu-cassandra-database \
    creation_statements="CREATE USER '{{username}}' WITH PASSWORD '{{password}}' SUPERUSER; \
          GRANT ALL ON KEYSPACE ktuspace TO {{username}};" \
    default_ttl="1h" \
    max_ttl="24h"

## Create Cassandra user role
echo "[*] Creating Cassandra user role..."
vault write database/roles/cassandra-user-role \
    db_name=ktu-cassandra-database \
    creation_statements="CREATE USER '{{username}}' WITH PASSWORD '{{password}}' NOSUPERUSER; \
          GRANT SELECT ON ktuspace.songs TO {{username}};" \
    default_ttl="1h" \
    max_ttl="24h"


echo "[*] Vault was successfully configured."