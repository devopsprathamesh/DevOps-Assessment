module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = local.clustername
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    attach_cluster_primary_security_group = true
    instance_types = ["t3.large"]
  }

  eks_managed_node_groups = {
    myeks-cluster-wg = {
      min_size     = 1
      max_size     = 2
      desired_size = 1
      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
      tags = {
         EKS = "DEV"
      }
    }
  }

  enable_cluster_creator_admin_permissions = true
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}