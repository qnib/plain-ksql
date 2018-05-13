FROM qnib/uplain-maven AS build

ARG CONFLUENT_VERSION=v4.1.1-rc3
ARG CONFLUENT_COMMON_VER=v4.1.1-rc3

RUN apt-get install -y git \
 && mkdir -p /usr/src/ \
 && cd /usr/src/ \
 && git clone --branch ${CONFLUENT_COMMON_VER} https://github.com/confluentinc/common
RUN cd /usr/src/common \
 && mvn -Dmaven.test.skip=true -DskipTests clean install
RUN git clone https://github.com/confluentinc/ksql /opt/ksql
RUN cd /opt/ksql/build-tools \
 && mvn -DskipTests -Dmaven.test.skip=true --quiet clean package install
 RUN cd /opt/ksql/ \
 && mvn -DskipTests -Dmaven.test.skip=true --quiet clean package install


FROM qnib/uplain-openjre8

ENV KAFKA_BROKERS=tasks.brokers:9092 \
    KSQL_APP_ID=ksql_test \
    ENTRYPOINTS_DIR=/opt/qnib/entry
COPY opt/qnib/entry/21-ksqlserver-properties.sh /opt/qnib/entry/
COPY opt/qnib/ksql/server.properties /opt/qnib/ksql/
COPY --from=build /opt/ksql /opt/ksql/
#COPY --from=build /opt/ksql/bin/* /usr/bin/
#COPY --from=build /opt/ksql/ksql-cli/target/ksql-cli-*-SNAPSHOT.jar \
#    /opt/ksql/ksql-cli/target/ksql-cli-*-SNAPSHOT-standalone.jar \
#    /usr/share/java/ksql-cli/
#COPY --from=build /opt/ksql/ksql-rest-app/target/ksql-rest-app-*.jar \
#    /usr/share/java/ksql-rest-app/
#COPY --from=build /opt/ksql/ksql-core/target/ksql-core-*-SNAPSHOT.jar \
#     /usr/share/java/ksql-core/

CMD ["/opt/ksql/bin/ksql-server-start", "/etc/ksql/server.properties"]
