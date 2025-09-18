# outputs.tf

output "s3_bucket_name" {
  description = "The name of the S3 bucket for the frontend"
  value       = aws_s3_bucket.frontend.id
}

output "lambda_function_name" {
  description = "The name of the backend Lambda function"
  value       = aws_lambda_function.backend.function_name
}

output "api_gateway_url" {
  description = "The invoke URL of the API Gateway"
  value       = aws_apigatewayv2_stage.default.invoke_url
}
