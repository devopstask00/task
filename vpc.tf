module "dev-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "dev-vpc"
  cidr = var.dev_vpc_cidr_block

  azs             = [var.first_subnet_az, var.second_subnet_az]
  private_subnets = [var.dev_private_subnets1, var.dev_private_subnets2]
  public_subnets  = [var.dev_public_subnets1, var.dev_public_subnets2]
  database_subnets    = [var.dev_database_subnets1, var.dev_database_subnets2]
  elasticache_subnets = [var.dev_elasticache_subnets1, var.dev_elasticache_subnets2]
  intra_subnets       = [var.dev_intra_subnets1, var.dev_intra_subnets2]

  enable_nat_gateway = true
  manage_default_network_acl = false
  single_nat_gateway = true
  enable_dns_hostnames = true
  map_public_ip_on_launch = true

    
  tags = {
    Terraform = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/internal-elb"             = 1
  }
}

resource "aws_security_group" "allow-web-traffic" {
  name        = "allow_tls"
  description = "Allow web traffic"
  vpc_id      = module.dev-vpc.vpc_id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "forjenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.101.0.0/16"]
  }

    ingress {
    description = "loki"
    from_port   = 3100
    to_port     = 3100
    protocol    = "tcp"
    cidr_blocks = ["10.101.0.0/16"]
  }

      ingress {
    description = "mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.101.0.0/16"]
  }

      ingress {
    description = "loki-memberlist"
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    cidr_blocks = ["10.101.0.0/16"]
  }

    ingress {
    description = "forIngress"
    from_port   = 9443
    to_port     = 9443
    protocol    = "tcp"
    cidr_blocks = ["10.101.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-web"
  }
}


resource "aws_default_network_acl" "nacl-def-dev" {
  default_network_acl_id = module.dev-vpc.default_network_acl_id

  ingress  {
    protocol   = -1
    rule_no    = 32766
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = -1
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 32766
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  egress {
    protocol   = -1
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  tags = {
    Name = "nacl-def-dev"
  }
}

module "prod-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "prod-vpc"
  cidr = var.prod_vpc_cidr_block


  azs             = [var.first_subnet_az, var.second_subnet_az]
  private_subnets = [var.prod_private_subnets1, var.prod_private_subnets2]
  public_subnets  = [var.prod_public_subnets1, var.prod_public_subnets2]
  database_subnets    = [var.prod_database_subnets1, var.prod_database_subnets2]
  elasticache_subnets = [var.prod_elasticache_subnets1, var.prod_elasticache_subnets2]
  intra_subnets       = [var.prod_intra_subnets1, var.prod_intra_subnets2]


  enable_nat_gateway = true
  manage_default_network_acl = false
  single_nat_gateway = true
  enable_dns_hostnames = true
  map_public_ip_on_launch = true

  tags = {
    Terraform = "true"
    Environment = "prod"
  }
}


resource "aws_security_group" "prod-allow-web-traffic" {
  name        = "allow_tls"
  description = "Allow web traffic"
  vpc_id      = module.prod-vpc.vpc_id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-web"
  }
}

resource "aws_default_network_acl" "nacl-def-prod" {
  default_network_acl_id = module.prod-vpc.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 32766
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 32766
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  egress {
    protocol   = -1
    rule_no    = 110
    action     = "allow"
    cidr_block = "10.102.0.0/16"
    from_port  = 0
    to_port    = 0
  }
    tags = {
    Name = "nacl-def-prod"
  }
}