#!/bin/bash

mkdir -p /etc/ksql/
echo "[II] Write config using: KAFKA_BROKERS=${KAFKA_BROKERS}"
cat /opt/qnib/ksql/server.properties \
   | sed -e "s/KAFKA_BROKERS/${KAFKA_BROKERS}/" \
   | sed -e "s/KSQL_APP_ID/${KSQL_APP_ID}/" \
   > /etc/ksql/server.properties
