# Instruction

## Set-up :

- Clone the Repository and navigate to the repository folder.
- We want to remove the `.git` folder as we will be reinitialising the project on AWS.
- In the terminal remove the `.git` folder using `rm -rf .git` command.

## AWS Credentials :

- Create `.aws` folder in the root of the project.
- Create `credentials` file inside the directory and copy the following code into it, replace 'YOUR_VALUES' with your own credentials:

```
[aws-cred]
aws_access_key_id = "YOUR_VALUES"
aws_secret_access_key = "YOUR_VALUES"
```

## Terraform :

- open ./infrastructure/terraform.tfvars and set `YOUR_VALUES`
- cd into infrastructure cd infrastructure/ and run `terraform init` to initialize the project.
- run `terraform plan` to review changes
- run `terraform apply` to apply and create resources.

## CodeCommit :

- Change directory to root folder in the terminal using `cd ..` command
- Initialize the project using `git init` command
- Add remote repository using `git remote add origin https://git-codecommit.eu-west-2.amazonaws.com/v1/repos/YOUR_VALUES` command (NOTE 'YOUR_VALUES' is the repository name and should be replaced if repository name has been changed in module as well as `eu-west-2` region of aws if region has been changed.)

## CodePipeline :

- AWS will run the Codepipeline and push the necessary files required to protect the main branch
- The Codepipeline will also create a `.gitignore` file so you must delete your local `.gitignore` file
- Once the Codepipeline is executed, run `git pull origin main` to pull latest changes
- run `npm install` to install all dependencies
- run `npm prepare` to execute chmod and protect main branch.
