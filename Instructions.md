# Instructions

## Terraform

1. create a `.aws` folder in the root and a `credentials` file inside .aws
2. copy the following code into `credentials` and replace `YOUR_VALUES` with your own credentials:
   ```
   [aws-cred]
   aws_access_key_id = "YOUR_VALUES"
   aws_secret_access_key = "YOUR_VALUES"
   ```
3. open ./infrastructure/terraform.tfvars and set `YOUR_VALUES`
4. cd into infrastructure `cd infrastructure/` and run `terraform init` to initialize the project.
5. run `terraform plan` to review changes
6. run `terraform apply` to apply and create resources.

## Push to CodeCommit

- Must add .gitignore file on first push otherwise all files will be uploaded into the repository.
- cd into root folder before initializing git folder

1. Change directory to root folder in the terminal using `cd ..` command
2. Copy the following code in the terminal (change values if required ie 'RepoName'):

   ```
   git init
   git remote add origin https://git-codecommit.eu-west-2.amazonaws.com/v1/repos/YOUR_VALUES
   git checkout -b main
   git add .gitignore
   git commit -m "Initial commit, Gitignore"
   git push origin main
   ```

   `   git init
   git remote add origin git@github.com:SurPun2/CodeCommit-Module.git
   git checkout -b main
   git add .gitignore
   git commit -m "Initial commit, Gitignore"
   git push origin main`

## CI/CD

- AWS will run the codepipeline and push the necessary files required to protect the main branch

1. Once the Codepipeline is executed, `git pull origin main` to pull latest changes
2. run `npm install` to install all dependencies
3. run `npm prepare` to execute chmod and protect main branch.
