variable "repository_name" {
  description = "The name of the CodeCommit repository."
  type        = string
}

variable "description" {
  description = "A description of the CodeCommit repository."
  type        = string
  default     = ""
}

variable "default_branch" {
  description = "The name of the default branch"
  type        = string
  default     = "main"
}
