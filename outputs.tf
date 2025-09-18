output "s3_bucket_name" {
  value = aws_s3_bucket.frontend.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.users.name
}

output "api_gateway_url" {
  value = aws_apigatewayv2_stage.default.invoke_url
}
