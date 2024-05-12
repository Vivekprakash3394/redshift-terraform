output "redshift-arn" {
    value = aws_iam_role.redshift.arn
}

output "redshift-cluster" {
    value = aws_redshift_cluster.redshift.database_name 
}

output "redshift-s3-bucket" {
    value = aws_s3_bucket.fe_redshift_au.bucket
}

output "redshift-db-password" {
  description = "redshift db cluster Password"
  value       = aws_redshift_cluster.redshift.master_password
  sensitive   = true
}