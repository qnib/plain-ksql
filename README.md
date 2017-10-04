# plain-ksql
Image holding the Kafka's KSQL

### Producer

To feed the KSQL processor a producer is used. Just create a new bash in the broker and drop `JMX_PORT`.

```
$ unset JMX_PORT
$ /opt/kafka/bin/kafka-console-producer.sh --broker-list tasks.broker:9092 --topic input
{"data":"test"}
{"data":"test3"}
```

### KSQL

```
ksql> CREATE STREAM data (data VARCHAR) WITH (VALUE_FORMAT = 'JSON', KAFKA_TOPIC = 'input');

 Message
----------------
 Stream created
ksql> SHOW STREAMS;

 Stream Name | Kafka Topic | Format
------------------------------------
 DATA        | input       | JSON
ksql> SELECT * FROM data;
1507107288461 | null | test3
```
