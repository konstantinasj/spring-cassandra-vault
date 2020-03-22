#!/usr/bin/env bash

## Unseal Vault
echo "[*] Unsealing Vault..."
vault operator unseal -tls-skip-verify $(grep 'Key 1:' /vault/keys.txt | awk '{print $NF}')
vault operator unseal -tls-skip-verify $(grep 'Key 2:' /vault/keys.txt | awk '{print $NF}')
vault operator unseal -tls-skip-verify $(grep 'Key 3:' /vault/keys.txt | awk '{print $NF}')

echo "[*] Vault was successfully unsealed."