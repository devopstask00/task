# ------------------------------------------------------------
# Jenkins Settings
# ------------------------------------------------------------
variable "jenkins_admin_user" {
  type        = string
  description = "Admin user of the Jenkins Application."
  default     = "admin"
}

variable "jenkins_admin_password" {
  type        = string
  description = "Admin password of the Jenkins Application."
}
# ------------------------------------------------------------
# EKS Cluster Settings
# ------------------------------------------------------------
variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster."
  default     = "dev-cluster"
}

variable "cluster-oidc" {
  type        = string
  description = "The address of the oidc cluster."
  default     = "96873E171F326E945C297E4B4CDD4FB0"
}

variable "cluster_version" {
  type        = string
  description = "The version of the EKS cluster."
  default     = "1.22"
}

variable "worker_group_name" {
  type        = string
  description = "The name of the EKS worker node group."
  default     = "dev-worker-group-1"
}

variable "worker_group_instance_type" {
  type        = list(string)
  description = "The instance type of the worker group nodes. Must be large enough to support the amount of NICS assigned to pods."
  default     = ["t3.medium"]
}

variable "autoscaling_group_min_size" {
  type        = number
  description = "The minimum number of nodes the worker group can scale to."
  default     = 1
}

variable "autoscaling_group_desired_capacity" {
  type        = number
  description = "The desired number of nodes the worker group should attempt to maintain."
  default     = 2
}

variable "autoscaling_group_max_size" {
  type        = number
  description = "The maximum number of nodes the worker group can scale to."
  default     = 3
}

variable "create_cluster_primary_security_group_tags" {
  description = "Indicates whether or not to tag the cluster's primary security group. This security group is created by the EKS service, not the module, and therefore tagging is handled after cluster creation"
  type        = bool
  default     = true
}
# ------------------------------------------------------------
# Networking Settings
# ------------------------------------------------------------
variable "aws_region" {
  type        = string
  description = "The AWS region for the provider to deploy resources into."
  default     = "us-west-2"
}

variable "first_subnet_az" {
  type        = string
  description = "Availability Zone of the 1st subnet."
  default     = "us-west-2a"
}

variable "second_subnet_az" {
  type        = string
  description = "Availability zone of 2nd subnet."
  default     = "us-west-2b"
}

variable "dev_vpc_cidr_block" {
  type        = string
  description = "CIDR block of the dev VPC to create."
  default     = "10.101.0.0/16"
}


variable "dev_private_subnets1" {
  type        = string
  default     = "10.101.1.0/24"
}

variable "dev_private_subnets2" {
  type        = string
  default     = "10.101.2.0/24"
}

variable "dev_public_subnets1" {
  type        = string
  default     = "10.101.101.0/24"
}

variable "dev_public_subnets2" {
  type        = string
  default     = "10.101.102.0/24"
}

variable "dev_database_subnets1" {
  type        = string
  default     = "10.101.4.0/24"
}

variable "dev_database_subnets2" {
  type        = string
  default     = "10.101.5.0/24"
}

variable "dev_elasticache_subnets1" {
  type        = string
  default     = "10.101.7.0/24"
}

variable "dev_elasticache_subnets2" {
  type        = string
  default     = "10.101.8.0/24"
}

variable "dev_intra_subnets1" {
  type        = string
  default     = "10.101.10.0/24"
}

variable "dev_intra_subnets2" {
  type        = string
  default     = "10.101.11.0/24"
}


variable "prod_vpc_cidr_block" {
  type        = string
  description = "CIDR block of the prod VPC to create."
  default     = "10.102.0.0/16"
}

variable "prod_private_subnets1" {
  type        = string
  default     = "10.102.1.0/24"
}

variable "prod_private_subnets2" {
  type        = string
  default     = "10.102.2.0/24"
}

variable "prod_public_subnets1" {
  type        = string
  default     = "10.102.101.0/24"
}

variable "prod_public_subnets2" {
  type        = string
  default     = "10.102.102.0/24"
}

variable "prod_database_subnets1" {
  type        = string
  default     = "10.102.4.0/24"
}

variable "prod_database_subnets2" {
  type        = string
  default     = "10.102.5.0/24"
}

variable "prod_elasticache_subnets1" {
  type        = string
  default     = "10.102.7.0/24"
}

variable "prod_elasticache_subnets2" {
  type        = string
  default     = "10.102.8.0/24"
}

variable "prod_intra_subnets1" {
  type        = string
  default     = "10.102.10.0/24"
}

variable "prod_intra_subnets2" {
  type        = string
  default     = "10.102.11.0/24"
}





variable "dev1_subnet_nic_private_ip" {
  type        = list(string)
  description = "CIDR block of subnet 1 to create."
  default     = ["10.0.1.50"]
}

