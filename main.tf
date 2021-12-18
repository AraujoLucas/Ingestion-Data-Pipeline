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
  conn_url     = "jdbc:postgresql://10.100.133.37:5432/db_x"
  conn_user    = "luciano.stoppa@olisaude.com.br"
  conn_pwd     = "default123"

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

module "glue-job-2" {
  source               = "./modules/glue-job-module/"
  job_name             = "data_aggregator"
  job_version          = "2.0"
  job_script_location  = "s3://artifacts-684264620210/data_agreggator.py"
  job_language         = "python"
}

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