# Terraform S3 Static Website (LocalStack)

This project demonstrates how to deploy a **static website on AWS S3 using Terraform**, running on **LocalStack** for local cloud development and testing.

---

## 🛠️ Technologies Used
- Terraform
- AWS S3
- LocalStack
- HTML

---

## 📂 Project Structure
```text
.
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── index.html
├── error.html
└── README.md

🚀 What This Project Does

-Creates an S3 bucket on LocalStack

-Enables static website hosting

-Uploads index.html and error.html

-Outputs the website endpoint

⚙️ Prerequisites

-Docker

-LocalStack

-Terraform

▶️ Run LocalStack
docker run -d -p 4566:4566 localstack/localstack

▶️ How to Run Terraform
terraform init
terraform plan
terraform apply

## 🔄 LocalStack vs AWS (Code-Level Difference)

The Terraform code remains **exactly the same** for both LocalStack and real AWS.  
The only difference is in **how we interact with AWS services**.

### 🧪 LocalStack
- Uses a local AWS cloud emulator
- Requires `awslocal` instead of `aws`
- Uses dummy credentials
- Faster, free, and safe for testing

Example:
```bash
awslocal s3 ls

Terraform provider configuration:

**hcl**
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  endpoints {
    s3                           = "http://s3.localhost.localstack.cloud:4566"
  }
}
☁️ Real AWS
Uses actual AWS services

Uses the standard aws CLI

Requires real credentials

Suitable for production workloads

Example:

**bash**
aws s3 ls

Terraform provider configuration:
**hcl**
provider "aws" {
  region = "us-east-1"
}

✅ Key takeaway:
The infrastructure code does not change — only the provider configuration and CLI tooling differ.

🌐 Access the Website
After applying, Terraform will output the S3 website endpoint provided by LocalStack.

🧹 Cleanup
terraform destroy


📌 Author:
```text
SalmaEasa