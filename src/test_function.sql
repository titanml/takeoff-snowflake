USE ROLE CONTAINER_USER_ROLE;
USE DATABASE CONTAINER_HOL_DB;
USE SCHEMA PUBLIC;
USE WAREHOUSE CONTAINER_HOL_WH;

CREATE OR REPLACE TABLE LLM_TEST (
    PROMPT VARCHAR,
    ANSWER VARCHAR
);

INSERT INTO LLM_TEST (PROMPT, ANSWER) 
    VALUES 
        ('List three things to do in London', NULL),
        ('List three things to do in Manchester', NULL),
        ('List three things to do in Liverpool', NULL),
        ('List three things to do in Cambridge', NULL),
        ('List three things to do in Oxford', NULL),
        ('List three things to do in Birmingham', NULL),
        ('List three things to do in Newcastle', NULL),
        ('List three things to do in Bristol', NULL),
        ('List three things to do in Leeds', NULL),
        ('List three things to do in Southampton', NULL);

SELECT * FROM LLM_TEST;



CREATE OR REPLACE FUNCTION generate_endpoint (input VARIANT)
RETURNS VARIANT
SERVICE=TAKEOFF_SERVICE      //Snowpark Container Service name
ENDPOINT='takeoff-snowflake'   //The endpoint within the container
MAX_BATCH_ROWS=5         //limit the size of the batch
AS '/generate_snowflake';           //The API endpoint


SELECT generate_endpoint(OBJECT_CONSTRUCT('text', 'list three things to do in London')) AS conversion_result;


UPDATE LLM_TEST
SET ANSWER = generate_endpoint(OBJECT_CONSTRUCT('text', PROMPT));

SELECT * FROM LLM_TEST;