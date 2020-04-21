# Hands-on Kafka

## docker-compose

There are two docker-compose files:

* kafka-multiple.yml that will start 3 Kafka brokers in a cluster
* kafka-single.yml that will start only 1 Kafka broker

To start use -f option:

````
docker-compose -f kafka-single.yml up
````


kafka-avro-console-producer \
    --broker-list localhost:9092 --topic client \
    --property value.schema='{"type":"record","name":"test","fields":[{"name":"number","type":"string"}, {"name":"name","type":"string"}]}'
{"number":"1010","name":"Maria"}


kafka-avro-console-consumer --bootstrap-server localhost:9092 --topic CLIENT_STREAM --property value.schema='{"type":"record","name":"test","fields":[{"name":"number","type":"string"}, {"name":"name","type":"string"}]}'