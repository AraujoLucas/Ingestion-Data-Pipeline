# ----- layer for configuration -----#
provider "aws" {
  # ... other configuration ...
  version = "~>2.70.0"
  region  = "us-east-1"
}
# ----- layer for ingestion -----#
module "glue-job-1" {
  source               = "./modules/glue-job-module/"
  job_name             = "data_generate"
  job_version          = "2.0"
  job_script_location  = "s3://artifacts-684264620210/data_ingestion.py"
  job_language         = "python"
}

module "glue_connection" {
  source       = "./modules/glue-connections-module"
  conn_name    = "connection_pg"
  conn_url     = "jdbc:postgresql://192.168.97.132:5432/olisaude"
  conn_user    = "olidbuser"
  conn_pwd     = "holistico123"

}

# ----- layer for catalog data -----#
module "crawler-1" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-company"
  glue_crawler_database_name    = "db_fonte_manual"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/company/data-analysis/"

}

module "crawler-2" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-cnu-sinister"
  glue_crawler_database_name    = "db_fonte_manual"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/cnu/sinister/"
}

module "crawler-3" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-cnu-beneficiary"
  glue_crawler_database_name    = "db_fonte_manual"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/cnu/beneficiary/"
}

module "crawler-4" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-bradesco-beneficiary"
  glue_crawler_database_name    = "db_fonte_manual"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/bradesco/beneficiary/"
}

module "crawler-5" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-bradesco-sinister"
  glue_crawler_database_name    = "db_fonte_manual"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/bradesco/sinister/"
}

module "crawler-6" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-gndi-beneficiary"
  glue_crawler_database_name    = "db_fonte_manual"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/gndi/beneficiary/"
}

# ----- layer for storage -----#
module "bucket_1" {
  source  = "./modules/s3-module/"
  name    = "corp-raw-684264620210"
}

module "bucket_2" {
  source  = "./modules/s3-module/"
  name    = "corp-analytics-684264620210"
}

module "bucket_3" {
  source  = "./modules/s3-module/"
  name    = "artifacts-684264620210"
}

module "bucket_4" {
  source  = "./modules/s3-module/"
  name    = "wkg-results-684264620210"
}

# ----- layer for processing -----#

# module "glue-job-2" {
#   source               = "./modules/glue-job-module/"
#   job_name             = "data_aggregator"
#   job_version          = "2.0"
#   job_script_location  = "s3://artifacts-684264620210/data_agreggator.py"
#   job_language         = "python"
# }

# ----- layer for visualization -----#

 module "athena_workgroup" {
    source = "./modules/athena-workgroup-module/" 
    #encryption_option = "SSE_KMS"{
      #kms_key_arn = module.s3_kms_key.aws_kms_key_arn
    #}
    
    # tags  = {
    #   Application = var.application
    #   Environment = var.environment
    #   Automation  = "Terraform"
    # }
}