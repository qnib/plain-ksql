# plain-ksql
Image holding the Kafka's KSQL

### Problem

**Currently not working** I get this error... :/

```
> execute CMD 'ksql-server-start /etc/ksql/server.properties'
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/share/java/ksql-cli/ksql-cli-0.1-SNAPSHOT-standalone.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/share/java/ksql-rest-app/ksql-rest-app-0.1-SNAPSHOT-standalone.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
Exception in thread "main" io.confluent.ksql.exception.KafkaResponseGetFailedException: Failed to retrieve kafka topic names
	at io.confluent.ksql.util.KafkaTopicClientImpl.listTopicNames(KafkaTopicClientImpl.java:78)
	at io.confluent.ksql.util.KafkaTopicClientImpl.isTopicExists(KafkaTopicClientImpl.java:70)
	at io.confluent.ksql.util.KafkaTopicClientImpl.createTopic(KafkaTopicClientImpl.java:44)
	at io.confluent.ksql.rest.server.KsqlRestApplication.buildApplication(KsqlRestApplication.java:219)
	at io.confluent.ksql.rest.server.KsqlRestApplication.main(KsqlRestApplication.java:189)
Caused by: java.util.concurrent.ExecutionException: org.apache.kafka.common.errors.TimeoutException: Timed out waiting for a node assignment.
	at org.apache.kafka.common.internals.KafkaFutureImpl.wrapAndThrow(KafkaFutureImpl.java:45)
	at org.apache.kafka.common.internals.KafkaFutureImpl.access$000(KafkaFutureImpl.java:32)
	at org.apache.kafka.common.internals.KafkaFutureImpl$SingleWaiter.await(KafkaFutureImpl.java:89)
	at org.apache.kafka.common.internals.KafkaFutureImpl.get(KafkaFutureImpl.java:213)
	at io.confluent.ksql.util.KafkaTopicClientImpl.listTopicNames(KafkaTopicClientImpl.java:76)
	... 4 more
Caused by: org.apache.kafka.common.errors.TimeoutException: Timed out waiting for a node assignment.
```

### Producer

To feed the KSQL processor a producer is used. Just create a new bash in the broker and drop `JMX_PORT`.

```
$ unset JMX_PORT
$ /opt/kafka/bin/kafka-console-producer.sh --broker-list tasks.broker:9092 --topic input
{"data":"test"}
```

### KSQL

```
CREATE STREAM data (data VARCHAR) WITH (VALUE_FORMAT = 'JSON', KAFKA_TOPIC = 'input');
```
