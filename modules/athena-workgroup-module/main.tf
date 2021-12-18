resource "aws_athena_workgroup" "queries" {
  name     = var.wkg_name

  configuration {
    enforce_workgroup_configuration    = var.enforce_workgroup_configuration
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = format("s3://%s/", var.query_output_locations)
    }
  }
}