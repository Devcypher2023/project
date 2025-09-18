output "s3_bucket_name" {
  value = aws_s3_bucket.frontend.id
}

output "lambda_function_name" {
  value = aws_lambda_function.backend.function_name
}
