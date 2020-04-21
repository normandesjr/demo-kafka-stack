CREATE STREAM postgres_wrapper
  (payload STRUCT<
    id BIGINT,
    amount INTEGER,
    number VARCHAR>)
  WITH (KAFKA_TOPIC='postgres-02-recharge',
        VALUE_FORMAT='JSON', PARTITIONS=1, REPLICAS=1);

CREATE STREAM recharge_stream WITH (PARTITIONS=1) AS
  SELECT payload->id AS ID, payload->amount AS AMOUNT, payload->number AS NUMBER FROM postgres_wrapper PARTITION BY NUMBER;

CREATE TABLE client_table
  (number VARCHAR,
  name VARCHAR)
  WITH (KAFKA_TOPIC='client', KEY='number',
        PARTITIONS=1, REPLICAS=1,
        VALUE_FORMAT='JSON');

CREATE STREAM result AS 
  SELECT C.NUMBER AS phone_number
       , C.NAME AS name
       , R.AMOUNT AS amount 
    FROM RECHARGE_STREAM R INNER JOIN CLIENT_TABLE C ON R.NUMBER = C.NUMBER EMIT CHANGES;

CREATE TABLE total AS 
  SELECT C.NUMBER AS phone_number
       , C.NAME AS name
       , SUM(R.AMOUNT) AS total 
    FROM RECHARGE_STREAM R 
      INNER JOIN CLIENT_TABLE C ON R.NUMBER = C.NUMBER 
    GROUP BY (C.NUMBER, C.NAME)
    EMIT CHANGES;



