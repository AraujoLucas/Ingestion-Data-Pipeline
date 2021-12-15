# ----- Camada de configuracao -----#
provider "aws" {
  # ... other configuration ...
  version = "~>2.70.0"
  region = "us-east-1"
}

# ----- Camada de armazenamento -----#
#Raw 
resource "aws_s3_bucket" "bucket_1" {
  bucket = "corp-raw-684264620210"
  acl    = "private"

  tags = {
    Name        = "bucket-raw"
    Environment = "Dev"
  }
}

#Analytics
resource "aws_s3_bucket" "bucket_2" {
  bucket = "corp-analytics-684264620210"
  acl    = "private"

  tags = {
    Name        = "bucket-analytics"
    Environment = "Dev"
  }
}

#Artifacts
resource "aws_s3_bucket" "bucket_3" {
  bucket = "artifacts-684264620210"
  acl    = "private"

  tags = {
    Name        = "bucket-artifacts"
    Environment = "Dev"
  }
}

# ----- Camada de ingestao -----#
#Generate
resource "aws_glue_job" "job_ingestion" {
  glue_version  = "2.0"
  name     = "data_generate"
  role_arn = "arn:aws:iam::684264620210:role/datalake_devopsrole"

  command {
    script_location = "s3://artifacts-684264620210/data_ingestion.py"
  }
}
