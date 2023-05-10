// Lambda
resource "aws_lambda_function" "delete_codepipeline_lambda" {
  # function_name = "delete_codepipeline_lambda"
  # handler       = "index.handler"
  # role          = aws_iam_role.lambda_exec_role.arn
  # runtime       = "nodejs14.x"

  # s3_bucket = aws_s3_bucket.lambda_bucket.bucket
  # s3_key    = aws_s3_bucket_object.lambda_function_payload.key
  function_name = var.function_name
  handler       = var.handler
  role          = var.role_arn
  runtime       = var.runtime

  s3_bucket = var.s3_bucket
  s3_key    = var.s3_key
}
