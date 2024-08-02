// Setup Github Repository in Snowflake
// For more information, see:
//    https://docs.snowflake.com/en/developer-guide/git/git-overview 
//    https://docs.snowflake.com/en/developer-guide/git/git-setting-up


// A user with the CREATE INTEGRATION privilege granted may run this query to create an API integration allowing users to connect to a git provider.
-- USE ROLE securityadmin;
-- CREATE ROLE myco_git_admin;
-- GRANT CREATE INTEGRATION ON ACCOUNT TO ROLE myco_git_admin;

-- USE ROLE myco_db_owner;
-- GRANT USAGE ON DATABASE myco_db TO ROLE myco_git_admin;
-- GRANT USAGE ON SCHEMA myco_db.integrations TO ROLE myco_git_admin;

-- USE ROLE myco_secrets_admin;
-- GRANT USAGE ON SECRET myco_git_secret TO ROLE myco_git_admin;

-- USE ROLE myco_git_admin;
-- USE DATABASE myco_db;
-- USE SCHEMA myco_db.integrations;

-- CREATE OR REPLACE API INTEGRATION git_api_integration
--   API_PROVIDER = git_https_api
--   API_ALLOWED_PREFIXES = ('https://github.com/my-account')
--   ALLOWED_AUTHENTICATION_SECRETS = (myco_git_secret)
--   ENABLED = TRUE;


use role accountadmin;
use database DATAWAREHOUSE_POC_DB;

-- CREATE OR REPLACE SECRET github_pat_cmd_for_snfk_experiments
--   TYPE = password
--   USERNAME = 'carlosmirandadurand'
--   PASSWORD = '.............................................';

create or replace api integration GitHub_Integration
    api_provider = git_https_api
    api_allowed_prefixes = ('https://github.com/carlosmirandadurand')
    allowed_authentication_secrets = (github_pat_cmd_for_snfk_experiments)
    enabled = true
    comment='Github integration to CMD Account';

CREATE GIT REPOSITORY snfk_experiments 
	ORIGIN = 'https://github.com/carlosmirandadurand/snfk_experiments' 
	API_INTEGRATION = 'GITHUB_INTEGRATION';
