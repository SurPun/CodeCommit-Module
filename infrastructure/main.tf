provider "aws" {
  region                  = "eu-west-2"
  shared_credentials_file = "../.aws/credentials"
  profile                 = "aws-cred"
}

// Codecommit
module "codecommit_repo" {
  source          = "./modules/code_commit"
  repository_name = var.repo_name
  description     = var.repo_description

  default_branch = "main"
}

// Lambda
data "archive_file" "lambda_function_payload" {
  type        = "zip"
  source_file = "./index.js"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "delete_codepipeline_lambda" {
  function_name = "delete_codepipeline_lambda"
  handler       = "index.handler"
  role          = aws_iam_role.lambda_exec_role.arn
  runtime       = "nodejs14.x"

  s3_bucket = aws_s3_bucket.lambda_bucket.bucket
  s3_key    = aws_s3_bucket_object.lambda_function_payload.key
}

// Lambda Bucket
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "lambda-function-bucket-del"
}

resource "aws_s3_bucket_object" "lambda_function_payload" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "lambda_function_payload.zip"
  source = data.archive_file.lambda_function_payload.output_path

  etag = filemd5(data.archive_file.lambda_function_payload.output_path)
}
