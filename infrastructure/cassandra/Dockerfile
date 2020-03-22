FROM cassandra:2.1.21

COPY ./config/cassandra.yaml /etc/cassandra/cassandra.yaml

COPY ./config/setup-data.cql /opt/setup-data.cql
COPY ./config/setup.sh /opt/setup.sh

RUN mkdir -p /opt/ssl
COPY ./ssl/node1.keystore.jks /opt/ssl/node1.keystore.jks
COPY ./ssl/ca.truststore.jks /opt/ssl/ca.truststore.jks
COPY ./ssl/ca.cer.pem /opt/ssl/ca.cer.pem

RUN mkdir -p /root/.cassandra
COPY ./config/cqlshrc /root/.cassandra/cqlshrc

RUN chmod o-rwx /etc/cassandra/cassandra.yaml
RUN chmod o-rwx /opt/ssl/node1.keystore.jks
RUN chmod o-rwx /opt/ssl/ca.truststore.jks
RUN chmod o-rwx /opt/ssl/ca.cer.pem

RUN chown -R cassandra /opt/ssl/