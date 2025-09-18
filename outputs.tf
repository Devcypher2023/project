# outputs.tf
output "cloudfront_distribution_id" {
  value = aws_s3_bucket.frontend.id  # Replace with CloudFront resource if you add CloudFront
}

output "s3_bucket_name" {
  value = aws_s3_bucket.frontend.id
}

output "lambda_function_name" {
  value = aws_lambda_function.backend.function_name
}
