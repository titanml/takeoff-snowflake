// This SQL script will create the takeoff service for the Snowpark Container Service and test the service

// Create the takeoff service
USE ROLE CONTAINER_USER_ROLE;


// **Note: use the following command if you work with normal takeoff in snowflake demo
-- create service CONTAINER_HOL_DB.PUBLIC.takeoff_service
--     in compute pool CONTAINER_HOL_POOL
--     from @specs
--     specification_file='takeoff-snowflake.yaml'
--     external_access_integrations = (ALLOW_ALL_EAI);

// **Note: use the following command if you work with Dataiku plugin demo
create service CONTAINER_HOL_DB.PUBLIC.takeoff_service
    in compute pool CONTAINER_HOL_POOL
    from @specs
    specification_file='takeoff-snowflake.yaml'
    external_access_integrations = (SNOWFLAKE_EGRESS_ACCESS_INTEGRATION); 


// Test takeoff service: get service status
CALL SYSTEM$GET_SERVICE_STATUS('CONTAINER_HOL_DB.PUBLIC.TAKEOFF_SERVICE');


// Test takeoff service: get service logs
CALL SYSTEM$GET_SERVICE_LOGS('CONTAINER_HOL_DB.PUBLIC.TAKEOFF_SERVICE', '0', 'takeoff',50);


// Show endpoints in service
SHOW ENDPOINTS IN SERVICE TAKEOFF_SERVICE;

