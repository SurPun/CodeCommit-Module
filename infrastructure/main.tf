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

// Null Resource
resource "null_resource" "codecommit_interaction" {
  triggers = {
    # Trigger the null resource on every run
    run_on_creation = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOT
    aws codecommit create-commit --repository-name ${module.codecommit_repo.repository_name} --branch-name ${module.codecommit_repo.default_branch} --put-files "filePath=text.md,fileContent=V2VsY29tZSB0byBvdXIgdGVhbSByZXBvc2l0b3J5IQo="
    EOT
  }
}

// Lambda
module "delete_codepipeline_lambda" {
  source = "./modules/lambda"

  function_name = "delete_codepipeline_lambda"
  handler       = "index.handler"
  role_arn      = aws_iam_role.lambda_exec_role.arn
  runtime       = "nodejs14.x"

  s3_bucket = aws_s3_bucket.lambda_bucket.bucket
  s3_key    = aws_s3_bucket_object.lambda_function_payload.key
}

// Lambda Bucket
data "archive_file" "lambda_function_payload" {
  type        = "zip"
  source_file = "./modules/lambda/index.js"
  output_path = "lambda_function_payload.zip"
}
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "lambda-function-bucket-del"
}

resource "aws_s3_bucket_object" "lambda_function_payload" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "lambda_function_payload.zip"
  source = data.archive_file.lambda_function_payload.output_path

  etag = filemd5(data.archive_file.lambda_function_payload.output_path)
}
