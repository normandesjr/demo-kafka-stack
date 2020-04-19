# Hands-on Kafka

## docker-compose

There are two docker-compose files:

* kafka-multiple.yml that will start 3 Kafka brokers in a cluster
* kafka-single.yml that will start only 1 Kafka broker

To start use -f option:

````
docker-compose -f kafka-single.yml up
````
