output "repository_url" {
  description = "The URL of the CodeCommit repository."
  value       = aws_codecommit_repository.codecommit_repository.clone_url_http
}

output "repository_name" {
  value = aws_codecommit_repository.codecommit_repository.repository_name
}

output "default_branch" {
  value = aws_codecommit_repository.codecommit_repository.default_branch
}
