variable "enable_glue_crawler" {
  description = "Enable glue crawler usage"
  default     = true
}

variable "glue_crawler_name" {
  description = "Name of the crawler."

}

variable "glue_crawler_database_name" {
  description = "Glue database where results are written."
  #default     = "db_fonte_manual"
  
}

variable "glue_crawler_role" {
  description = "(Required) The IAM role friendly name (including path without leading slash), or ARN of an IAM role, used by the crawler to access other resources."
  #default = "arn:aws:iam::account-id:role/service-role/AWSGlueServiceRole-data_polling"
}

variable "glue_crawler_s3_path" {
  description = "s3 for crawler polling"
  #default = "s3://corp-raw-account-id/company/data-analysis/"
}
