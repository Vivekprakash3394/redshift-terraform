If you want to create the redshift cluster, then apply this files from there only as it is separate module and not link with other.

Commands
# 1. terraform init
terraform init -var-file au.tfvars -backend-config=au.s3.tfbackend

# 2. terraform plan
terraform plan -var-file au.tfvars

# 3. terraform apply
terraform apply -var-file au.tfvars


## What this terraform template is doing?

### Create IAM policy
### Create IAM Role for redshift
### Attach Policy to IAM Role
### Create S3 Bucket
### Create Redshift Cluster
### Create Security Group for Redshift Cluster
### Create Redshift Subnet Group