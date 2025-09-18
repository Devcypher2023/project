variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "s3_bucket_name" {
  type    = string
  default = "luffy-utrains-5000e"
}

variable "dynamodb_table_name" {
  type    = string
  default = "userserverless"
}

variable "lambda_function_name" {
  type    = string
  default = "userserverless-lambda"
}
