resource "aws_glue_job" "job" {
  name          = var.job_name
  role_arn      = var.job_role
  glue_version  = var.job_version
  #connections     = var.connection_pg

  command {
    script_location = var.job_script_location 
  }
  default_arguments = {
     "--continuous-log-logGroup"          = aws_cloudwatch_log_group.log_groups.name
     "--enable-continuous-cloudwatch-log" = "true"
     #"--enable-continuous-log-filter"     = "true"
     "--enable-metrics"                   = "true"
  }
}
resource "aws_cloudwatch_log_group" "log_groups" {
  name              = "log_group_ingestion"
  retention_in_days = 14
}

# resource "aws_glue_job" "job_prossessing" {
#   name          = var.job_name
#   role_arn      = var.job_role
#   glue_version  = var.job_version

#   command {
#     script_location = var.job_script_location 
#   }
#   default_arguments = {
#     "--continuous-log-logGroup"          = aws_cloudwatch_log_group.log_groups_process.name
#     "--enable-continuous-cloudwatch-log" = "true"
#     "--enable-continuous-log-filter"     = "true"
#     "--enable-metrics"                   = "true"
#   }
# }
# resource "aws_cloudwatch_log_group" "log_groups_process" {
#   name              = "log_group_process"
#   retention_in_days = 14
# }