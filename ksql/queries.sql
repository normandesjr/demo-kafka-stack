CREATE STREAM test_query
  (payload STRUCT<
    id BIGINT,
    amount INTEGER,
    number VARCHAR>)
  WITH (KAFKA_TOPIC='postgres-02-recharge',
        VALUE_FORMAT='JSON');

CREATE STREAM first_stream AS
  SELECT payload->id AS ID, payload->amount AS AMOUNT, payload->number AS NUMBER FROM test_query EMIT CHANGES;

CREATE STREAM test_query2
  (number VARCHAR,
  name VARCHAR)
  WITH (KAFKA_TOPIC='client',
        PARTITIONS=1, REPLICAS=1,
        VALUE_FORMAT='JSON');

CREATE STREAM client_stream as 
  SELECT * FROM test_query2 EMIT_CHANGES;

