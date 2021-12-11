module "s3_raw" {
  source                         = "terraform-aws-modules/s3-bucket/aws"
  version                        = "v1.9.0"
  bucket                         = "${var.initials}-raw-${var.project}-${var.environment}"
  tags                           = local.tags
  acl                            = var.s3_raw_acl
  versioning                     = var.s3_raw_versioning
  lifecycle_rule                 = var.s3_raw_lifecycle_rule
  attach_elb_log_delivery_policy = false
  attach_public_policy           = false
}