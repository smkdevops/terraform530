module "eks_cluster" {

  source = "cps-terraform-dev.anthem.com/CORP/terraform-aws-eks-cluster/aws"  

  environment      = "production"
  company          = "antm"
  costcenter       = "1010101010"
  owner-department = "corpdemo1"
  it-department    = "service catalog"
  barometer-it-num = "100corp"
  application      = "scapp1"
  resource-type    = "eks"
  layer            = "DBx"
  compliance       = "None"
  application_dl   = "dl-ccoe-cloud-service-catalog@anthem.com"
  tags             = {}

  cluster_name = "SCTEAM-VINAY-CLUSTER"
  master_user  = "slvr-scapp1-devrole"
  additional_roles = [
    {
      rolearn  = "arn:aws:iam::544086441256:role/Test-NodeGroup-Role"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups = [
        "system:bootstrappers",
        "system:nodes",
        "system:masters",
        "apps",
        "batch",
        "extensions",
        "rbac.authorization.k8s.io"
      ]
    },    
    {
      rolearn  = "arn:aws:iam::544086441256:role/Test-NodeGroup-Role1"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups = [
        "system:bootstrappers",
        "system:nodes"
      ]
    }
  ]

}

module "terraform_aws_eks_node_group" {
  source = "cps-terraform-dev.anthem.com/CORP/terraform-aws-eks-node-group/aws"

  environment      = "production"
  company          = "antm"
  costcenter       = "1010101010"
  owner-department = "corpdemo1"
  it-department    = "service catalog"
  barometer-it-num = "100corp"
  application      = "scapp1"
  resource-type    = "eks"
  layer            = "DBx"
  compliance       = "None"
  application_dl   = "dl-ccoe-cloud-service-catalog@anthem.com"
  tags             = {}

  cluster_name    = module.eks_cluster.cluster_id
  image_id        = "ami-0118add3e78e39f65"
  user_data_file  = "user_data.sh"
  node_group_name = "test-node-group"
  node_group_role = "Test-NodeGroup-Role"
  #kubelet_extra_args = "--kubelet_extra_args --node-labels=mykey=myvalue,nodegroup=NodeGroup1"

  # instance_refresh = {
  #     strategy = "Rolling"
  #     preferences = {
  #       min_healthy_percentage = 50
  #       instance_warmup = 60
  #     }
  #     triggers = ["tag"]
  #   }   

}

module "terraform_aws_eks_node_group1" {
  source = "cps-terraform-dev.anthem.com/CORP/terraform-aws-eks-node-group/aws"

  environment      = "production"
  company          = "antm"
  costcenter       = "1010101010"
  owner-department = "corpdemo1"
  it-department    = "service catalog"
  barometer-it-num = "100corp"
  application      = "scapp1"
  resource-type    = "eks"
  layer            = "DBx"
  compliance       = "None"
  application_dl   = "dl-ccoe-cloud-service-catalog@anthem.com"
  tags             = {}

  cluster_name    = module.eks_cluster.cluster_id
  image_id        = "ami-0118add3e78e39f65"
  user_data_file  = "user_data.sh"
  node_group_name = "test-node-group1"
  node_group_role = "Test-NodeGroup-Role1"
  #kubelet_extra_args = "--kubelet_extra_args --node-labels=mykey=myvalue,nodegroup=NodeGroup1"

  # instance_refresh = {
  #     strategy = "Rolling"
  #     preferences = {
  #       min_healthy_percentage = 50
  #       instance_warmup = 60
  #     }
  #     triggers = ["tag"]
  #   }   

}

# module "terraform_aws_eks_node_group2" {
#   source = "cps-terraform-dev.anthem.com/CORP/terraform-aws-eks-node-group/aws"

#   environment      = "production"
#   company          = "antm"
#   costcenter       = "1010101010"
#   owner-department = "corpdemo1"
#   it-department    = "service catalog"
#   barometer-it-num = "100corp"
#   application      = "scapp1"
#   resource-type    = "eks"
#   layer            = "DBx"
#   compliance       = "None"
#   application_dl   = "dl-ccoe-cloud-service-catalog@anthem.com"
#   tags = {}

#   cluster_name       = module.eks_cluster.cluster_id
#   image_id           = "ami-0118add3e78e39f65" #"ami-0ee48b99098722c56"  #"ami-064389406d1f2d7a1" #"ami-0077c64c13c8d1884" #"ami-0eae5c669d80caa76"
#   user_data_file     = "user_data.sh"
#   node_group_name    = "test-node-group1"
#   #kubelet_extra_args = "--kubelet_extra_args --node-labels=mykey=myvalue,nodegroup=NodeGroup1"

#   # instance_refresh = {
#   #     strategy = "Rolling"
#   #     preferences = {
#   #       min_healthy_percentage = 50
#   #       instance_warmup = 60
#   #     }
#   #     triggers = ["tag"]
#   #   } 
# }
