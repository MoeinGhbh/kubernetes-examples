provider "aws" {
  region = "eu-central-1"  # Change this to your desired region
}

data "aws_iam_role" "eks-iam-role" {
  name = "eks-cluser-role"
}

resource "aws_eks_cluster" "park-eks" {
 name = "park-cluster"
 role_arn = data.aws_iam_role.eks-iam-role.arn

 vpc_config {
  subnet_ids = ["arn:aws:ec2:eu-central-1:688530700484:subnet/subnet-0dc08ceec76f5c515", "arn:aws:ec2:eu-central-1:688530700484:subnet/subnet-0ff390fdaf30e0d58"]
 }

# depends_on = [
#  aws_iam_role.eks-iam-role,
# ]
}

data "aws_iam_role" "workernodes" {
   name  = "AmazonEKSNodeRole"
}

resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.park-eks.name
  node_group_name = "devopsthehardway-workernodes"
  node_role_arn  = data.aws_iam_role.workernodes.arn
  subnet_ids   = [var.subnet_id_1, var.subnet_id_2]
  instance_types = ["t3.xlarge"]

  scaling_config {
   desired_size = 1
   max_size   = 1
   min_size   = 1
  }

  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   #aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
 }
