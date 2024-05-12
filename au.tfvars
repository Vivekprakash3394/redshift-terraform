aws_region                      = "ap-southeast-2"
env                             = "au"
fes_redshift                    = "fes-redshift"
product                         = "platform-engineering"

#redshift cluster configuration variables
redshift_cluster_identifier     = "redshift"
redshift_database_name          = "redshiftdb"
redshift_admin_username         = "admin"
redshift_node_type              = "dc2.large"
redshift_cluster_type           = "single-node"
redshift_number_of_nodes        = 1

#network variables
redshift_vpc_id                 = "vpc-0c663519422ffc8ha"
redshift_vpc_cidr               = "172.31.0.0/16"
private_subnet_ids              = ["subnet-0f4d15b157f3hs3e", "subnet-0cf77oalb28723708","subnet-0b06921403e780ab5"]