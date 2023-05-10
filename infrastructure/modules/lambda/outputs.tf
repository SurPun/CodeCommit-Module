output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.delete_codepipeline_lambda.arn
}

output "function_name" {
  description = "The name of the lambda function"
  value       = aws_lambda_function.delete_codepipeline_lambda.function_name
}
