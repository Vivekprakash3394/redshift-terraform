# Create policy
resource "aws_iam_policy" "s3_access_policy" {
  name        = "${var.fes_redshift}-${var.env}-policy"
  description = "IAM policy for accessing S3 resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:DeleteObject",
          "s3:ListAllMyBuckets"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::${var.fes_redshift}-${var.env}",
          "arn:aws:s3:::${var.fes_redshift}-${var.env}/*"
        ]
      }
    ]
  })
}

# Create IAM Role for redshift
resource "aws_iam_role" "redshift" {
  name = "${var.fes_redshift}-${var.env}-role"  
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Principal": {
                "Service": "redshift.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
}


# Attach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "redshift" {
  policy_arn = aws_iam_policy.s3_access_policy.arn
  role       = aws_iam_role.redshift.name
}

# Create S3 Bucket
resource "aws_s3_bucket" "fe_redshift_au" {
  bucket = "${var.fes_redshift}-${var.env}"
}

resource "aws_s3_bucket_ownership_controls" "fe_redshift_au" {
  bucket = aws_s3_bucket.fe_redshift_au.bucket
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_acl" "fe_redshift_au" {
  depends_on = [aws_s3_bucket_ownership_controls.fe_redshift_au]

  bucket = aws_s3_bucket.fe_redshift_au.bucket
  acl    = "private"
}

# Create Redshift Cluster
resource "aws_redshift_cluster" "redshift" {
  cluster_identifier         = "${var.redshift_cluster_identifier}-${var.env}"
  database_name              = var.redshift_database_name
  master_username            = var.redshift_admin_username
  master_password            = random_password.password.result
  node_type                  = var.redshift_node_type
  cluster_type               = var.redshift_cluster_type
  number_of_nodes            = var.redshift_number_of_nodes
  publicly_accessible        = false
  iam_roles                  = [aws_iam_role.redshift.arn]
  vpc_security_group_ids     = [aws_security_group.redshift_sg.id]
  cluster_subnet_group_name  = aws_redshift_subnet_group.redshift.name
  skip_final_snapshot        = true

  tags = {
    Environment = "${var.env}"
    Product     = "${var.product}"
  }
}

# Create Security Group for Redshift Cluster
resource "aws_security_group" "redshift_sg" {
  name        = "redshift_sg"
  description = "Redshift security group"
  vpc_id      = var.redshift_vpc_id
  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["${var.redshift_vpc_cidr}"]    
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Redshift Subnet Group
resource "aws_redshift_subnet_group" "redshift" {
  name       = "redshift-subnet-group"
  subnet_ids = [var.private_subnet_ids[0],var.private_subnet_ids[1],var.private_subnet_ids[2]]
}