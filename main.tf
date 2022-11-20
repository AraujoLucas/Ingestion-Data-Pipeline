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
  job_script_location  = "s3://bkt/data_ingestion.py"
  job_language         = "python"
}

# module "glue_connection" {
#   source       = "./modules/glue-connections-module"
#   conn_name    = "pg_connection"
#   conn_url     = ""
#   conn_pwd     = ""
# }

module "glue_connection_1" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.3.0"
  name        = "connection_pg"
 
  description = "Security Group"
  vpc_id      =  "vpc-id"
  ingress_with_self = [
    {
      description = "Security Group for connection}"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
    }
  ]
  egress_with_cidr_blocks = [{
    description = "Security Group for connection}"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
  }]
  # tags = local.tags
}

resource "aws_glue_connection" "glue_connection" {
  count           = 1
  name            = "connection_pg"
  description     = "Conexão com banco de dados pg do ambiente } "
  connection_type = "JDBC"
  connection_properties = {
    JDBC_CONNECTION_URL = "url"
    USERNAME            = "olidbuser"
    PASSWORD            = ""
  }
 
  physical_connection_requirements {
    availability_zone      = "us-east-1a"
    security_group_id_list = [module.glue_connection_1.security_group_id]
    subnet_id              = "subnet-id"
  }
}

# ----- layer for catalog data -----#
module "crawler-1" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-cnu-beneficiary"
  glue_crawler_database_name    = "db_cnu"
  glue_crawler_role             = "arn:aws:iam:::role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://bkt"


# ----- layer for storage -----#
module "bucket_1" {
  source  = "./modules/s3-module/"
  name    = "corp-raw-"
}

module "bucket_2" {
  source  = "./modules/s3-module/"
  name    = "corp-analytics-"
}

module "bucket_3" {
  source  = "./modules/s3-module/"
  name    = "artifacts-"
}

module "bucket_4" {
  source  = "./modules/s3-module/"
  name    = "wkg-results-"
}

# ----- layer for processing -----#

# module "glue-job-2" {
#   source               = "./modules/glue-job-module/"
#   job_name             = "data_aggregator"
#   job_version          = "2.0"
#   job_script_location  = "s3://artifacts/data_agreggator.py"
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
