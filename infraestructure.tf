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
#Results-work-group-analytics
resource "aws_s3_bucket" "bucket_4" {
  bucket = "results-work-group-analytics-684264620210"
  acl    = "private"

  tags = {
    Name        = "bucket-results"
    Environment = "Dev"
  }
}

# ----- Camada de ingestao -----#
#Generate
resource "aws_glue_job" "job_ingestion" {
  name     = "data_generate"
  role_arn = "arn:aws:iam::587791419323:role/AraujoEngineer"

  command {
    script_location = "s3://artifacts/example.py"
  }
}

# ----- Camada de processamento -----#
#Aggregator
resource "aws_glue_job" "job_transformer" {
  name     = "data_aggregator"
  role_arn = "arn:aws:iam::587791419323:role/AraujoEngineer"

  command {
    script_location = "s3://artifacts/example.py"
  }
}

# ----- Camada de visualizacao -----#
#Work-group-Analytics
resource "aws_athena_workgroup" "work-group" {
  name = "Work-group-analytics"

  configuration {
    enforce_workgroup_configuration    = true

    result_configuration {
      output_location = "s3://results-work-group-analytics-684264620210/output/"
    }
  }
}
