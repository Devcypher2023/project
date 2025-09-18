variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for static website"
  type        = string
  default     = "luffy-utrains-5000e"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "userserverless-lambda"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "userserverless"
}
