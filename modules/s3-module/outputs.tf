output "name" {
    value = aws_s3_bucket.bucket
  
}

output "arn" {
    value = aws_s3_bucket.bucket.arn
}