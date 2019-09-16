This repository contains terraform configuration files to deploy S3 and DynamoDB backend to store terraform state. This infrastructure setup is one time only per application.

## Setup

Run the below commands to setup remote state backend for Terraform:

```
export AWS_ACCESS_KEY_ID="<accesskey>"
export AWS_SECRET_ACCESS_KEY="<secretkey>"

terraform init
terraform apply -auto-approve
```

> Note the values of output variables: `BACKEND_BUCKET_NAME`, `BACKEND_TABLE_NAME`, `BACKEND_REGION`
