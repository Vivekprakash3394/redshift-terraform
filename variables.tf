variable "aws_region" {
  type = string
  description = "name of aws region"
}

variable "fes_redshift" {
  type = string
  description = "name of the redshift cluster"
}

variable "env" {
  type = string
  description = "env name of the redshift cluster"
}

variable "product" {
  type = string
  description = "team name of the redshift cluster"
}


# Redshift cluster configuration variable definition

variable "redshift_cluster_identifier" {
  type        = string
  description = "Redshift Cluster Identifier"
}

variable "redshift_database_name" { 
  type        = string
  description = "Redshift Database Name"
}

variable "redshift_admin_username" {
  type        = string
  description = "Redshift Admin Username"
}

variable "redshift_node_type" { 
  type        = string
  description = "Redshift Node Type"
  default     = "dc2.large"
}

variable "redshift_cluster_type" { 
  type        = string
  description = "Redshift Cluster Type"
  default     = "single-node"  // options are single-node or multi-node
}

variable "redshift_number_of_nodes" {
  type        = number
  description = "Redshift Number of Nodes in the Cluster"
  default     = 1
}


# Network configuration
variable "redshift_vpc_id" {
  type        = string
  description = "Private VPC IPv4"
}

variable "redshift_vpc_cidr" {
  description = "Redshift VPC CIDR"
  type        = string
}

variable "private_subnet_ids" {
  description = "private subnet ids"
  type        = list(string)
}