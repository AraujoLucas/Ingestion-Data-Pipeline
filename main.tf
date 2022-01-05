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

# module "glue_connection" {
#   source       = "./modules/glue-connections-module"
#   conn_name    = "pg_connection"
#   conn_url     = "jdbc:postgresql://192.168.69.84:5432/olisaude"
#   conn_pwd     = ""
# }

module "glue_connection_1" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.3.0"
  name        = "connection_pg"
 
  description = "Security Group"
  vpc_id      =  "vpc-00bfcdbe5e827f2a6"
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
    JDBC_CONNECTION_URL = "jdbc:postgresql://192.168.69.84:5432/olisaude"
    USERNAME            = "olidbuser"
    PASSWORD            = ""
  }
 
  physical_connection_requirements {
    availability_zone      = "us-east-1a"
    security_group_id_list = [module.glue_connection_1.security_group_id]
    subnet_id              = "subnet-0b0e20016e09b5f99"
  }
}

# ----- layer for catalog data -----#
module "crawler-1" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-cnu-beneficiary"
  glue_crawler_database_name    = "db_cnu"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/cnu/beneficiary/"

}

module "crawler-2" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-cnu-sinister"
  glue_crawler_database_name    = "db_cnu"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/cnu/sinister/"
}

module "crawler-3" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-bradesco-beneficiary"
  glue_crawler_database_name    = "db_bradesco"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/bradesco/beneficiary/"
}

module "crawler-4" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-bradesco-sinister"
  glue_crawler_database_name    = "db_bradesco"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/bradesco/sinister/"
}

module "crawler-5" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-gndi-beneficiary"
  glue_crawler_database_name    = "db_gndi"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/gndi/beneficiary/"
}

module "crawler-6" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-gndi-sinister"
  glue_crawler_database_name    = "db_gndi"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/gndi/sinister/"
}

module "crawler-7" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-sulamerica-benefiaciary"
  glue_crawler_database_name    = "db_sulamerica"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/sulamerica/benefiaciary/"
}

module "crawler-8" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-sulamerica-sinister"
  glue_crawler_database_name    = "db_sulamerica"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/sulamerica/sinister/"
}

module "crawler-9" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-amil-benefiaciary"
  glue_crawler_database_name    = "db_amil"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/amil/beneficiary/"
}

module "crawler-10" {
  source                        = "./modules/glue-crawler-module"
  glue_crawler_name             = "data-polling-amil-sinister"
  glue_crawler_database_name    = "db_amil"
  glue_crawler_role             = "arn:aws:iam::684264620210:role/service-role/AWSGlueServiceRole-data_polling"
  glue_crawler_s3_path          = "s3://corp-raw-684264620210/amil/sinister/"
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