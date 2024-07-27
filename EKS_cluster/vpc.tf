module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name = "my-SM-vpc"
  cidr = "10.10.0.0/16"

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
  intra_subnets   = local.intra_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
      "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags

}