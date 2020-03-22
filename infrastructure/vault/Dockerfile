FROM alpine:3.7

ENV VAULT_VERSION 1.3.2

RUN mkdir /vault

RUN apk --no-cache add \
      bash \
      ca-certificates \
      wget
RUN wget --quiet --output-document=/tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    unzip /tmp/vault.zip -d /vault && \
    rm -f /tmp/vault.zip && \
    chmod +x /vault

ENV PATH="PATH=$PATH:$PWD/vault"

COPY ./config/vault-config.json /vault/config/vault-config.json
COPY ./config/setup.sh /vault/config/setup.sh
COPY ./config/unseal.sh /vault/config/unseal.sh

COPY ./policies/admin_policy.hcl /vault/config/admin_policy.hcl
COPY ./policies/db_user_policy.hcl /vault/config/db_user_policy.hcl
COPY ./policies/client1_policy.hcl /vault/config/client1_policy.hcl

COPY ./ssl/vault.crt /vault/config/vault.crt
COPY ./ssl/vault.key /vault/config/vault.key

RUN chmod o-rwx /vault/config/vault-config.json
RUN chmod o-rwx /vault/config/vault.crt
RUN chmod o-rwx /vault/config/vault.key

EXPOSE 8200
ENTRYPOINT ["vault"]