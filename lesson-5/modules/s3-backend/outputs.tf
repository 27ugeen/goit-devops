output "bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "Created S3 bucket name"
}

output "table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "Created DynamoDB table name"
}