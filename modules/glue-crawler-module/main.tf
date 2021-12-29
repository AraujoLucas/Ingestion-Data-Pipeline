resource "aws_glue_crawler" "crawler" {

name                = var.glue_crawler_name
database_name       = var.glue_crawler_database_name
role                = var.glue_crawler_role

s3_target {
    path = var.glue_crawler_s3_path
  }
}
