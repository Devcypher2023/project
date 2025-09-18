variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "luffy-utrains-5000e"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name"
  type        = string
  default     = "userserverless"
}

variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
  default     = "userserverless-lambda"
}
