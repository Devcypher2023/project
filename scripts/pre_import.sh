#!/usr/bin/env bash
set -e

echo "��� Running pre-import sanity checks..."

# --- Check & Import S3 Bucket ---
if aws s3api head-bucket --bucket "${S3_BUCKET_NAME}" 2>/dev/null; then
  echo "✅ S3 bucket '${S3_BUCKET_NAME}' exists. Importing into Terraform state..."
  terraform import aws_s3_bucket.frontend "${S3_BUCKET_NAME}" || echo "Already imported or skipped."
else
  echo "ℹ️ No pre-existing bucket '${S3_BUCKET_NAME}' found. Terraform will create it."
fi

# --- Check & Import DynamoDB Table ---
if aws dynamodb describe-table --table-name "${DYNAMODB_TABLE_NAME}" 2>/dev/null; then
  echo "✅ DynamoDB table '${DYNAMODB_TABLE_NAME}' exists. Importing..."
  terraform import aws_dynamodb_table.users "${DYNAMODB_TABLE_NAME}" || echo "Already imported or skipped."
else
  echo "ℹ️ No pre-existing DynamoDB table '${DYNAMODB_TABLE_NAME}' found."
fi

# --- Check & Import IAM Role ---
if aws iam get-role --role-name "lambda_exec_role" 2>/dev/null; then
  echo "✅ IAM role 'lambda_exec_role' exists. Importing..."
  terraform import aws_iam_role.lambda_exec "lambda_exec_role" || echo "Already imported or skipped."
else
  echo "ℹ️ No pre-existing IAM role found."
fi

# --- Check & Import Lambda Function ---
if aws lambda get-function --function-name "${LAMBDA_FUNCTION_NAME}" 2>/dev/null; then
  echo "✅ Lambda function '${LAMBDA_FUNCTION_NAME}' exists. Importing..."
  terraform import aws_lambda_function.backend "${LAMBDA_FUNCTION_NAME}" || echo "Already imported or skipped."
else
  echo "ℹ️ No pre-existing Lambda function found."
fi

echo "✅ Pre-import checks completed!"

