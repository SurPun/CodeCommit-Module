variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "The handler for the Lambda function"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role for the Lambda function"
  type        = string
}

variable "runtime" {
  description = "The runtime for the Lambda function"
  type        = string
  default     = "nodejs14.x"
}

variable "s3_bucket" {
  description = "The S3 bucket containing the Lambda function's deployment package"
  type        = string
}

variable "s3_key" {
  description = "The S3 key for the Lambda function's deployment package"
  type        = string
}
