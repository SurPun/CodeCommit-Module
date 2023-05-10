// CodePipeline
resource "aws_codepipeline" "pipeline" {
  name     = "MyRepo-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.artifact-cicd.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["tf-code"]

      configuration = {
        BranchName           = "main"
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
        RepositoryName       = module.codecommit_repo.repository_name
      }
    }
  }

  stage {
    name = "Build"
    action {
      name            = "Build"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "cicd-build"
      }
    }
  }

  stage {
    name = "Cleanup"

    action {
      name             = "DeletePipeline"
      category         = "Invoke"
      owner            = "AWS"
      provider         = "Lambda"
      version          = "1"
      input_artifacts  = []
      output_artifacts = []

      configuration = {
        FunctionName = module.delete_codepipeline_lambda.function_name
      }
    }
  }
}

// Build
resource "aws_codebuild_project" "cicd-build" {
  name          = "cicd-build"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "REPOSITORY_URL"
      value = module.codecommit_repo.repository_url
    }
    environment_variable {
      name  = "REPOSITORY_NAME"
      value = module.codecommit_repo.repository_name
    }
    environment_variable {
      name  = "CURRENT_BRANCH"
      value = "current_branch=$(git symbolic-ref HEAD | sed -e \"s,.*/\\\\(.*\\\\),\\\\1,\")"
    }
    environment_variable {
      name  = "AUTHOR_NAME"
      value = var.author_name
    }
    environment_variable {
      name  = "AUTHOR_EMAIL"
      value = var.author_email
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("buildspec/buildspec.yml")
  }
}
