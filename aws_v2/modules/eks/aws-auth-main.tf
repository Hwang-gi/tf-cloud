data "aws_instances" "eks_nodes" {
  filter {
    name   = "tag:aws:eks:nodegroup-name"
    values = [for ng in local.node_groups : ng.node_group_name]
  }
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "${var.user_name}-aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<-EOT
      - rolearn: arn:aws:iam:${var.account_id}:role/${var.node_role_name}
        username: system:node:var.{join(",", [for instance in data.aws_instances.eks_nodes.instances : instance.private_dns])}
        groups:
          - system:bootstrappers
          - system:nodes
    EOT
    mapUsers = <<-EOT
      - userarn: arn:aws:iam:var.${var.account_id}:role/${var.user_role_name}
        username: ${var.user_name}
        groups:
          - system:masters
    EOT
  }
}
