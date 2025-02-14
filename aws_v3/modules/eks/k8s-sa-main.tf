# AWS Load Balancer Controller ServiceAccount
resource "kubernetes_service_account" "eks_oidc_sa" {
  metadata {
    name      = "eks-oidc-sa"
    namespace = "default"
    annotations = {
      "kubernetes.io/enforce-mountable-secrets" = "true"
    }
  }
}


# AWS Load Balancer Controller ServiceAccount
resource "kubernetes_service_account" "aws_load_balancer_controller_sa" {
  metadata {
    name      = "${var.alb_chart.name}-sa"
    namespace = "${var.alb_chart.namespace}"
    annotations = {
      "kubernetes.io/enforce-mountable-secrets" = "true"
    }
  }
}

# Cluster Autoscaler ServiceAccount
resource "kubernetes_service_account" "cluster_autoscaler_sa" {
  metadata {
    name      = "${var.cluster_autoscaler_chart.name}-sa"
    namespace = "${var.cluster_autoscaler_chart.namespace}"
    annotations = {
      "kubernetes.io/enforce-mountable-secrets" = "true"
    }
  }
}

# EFS CSI Driver ServiceAccount
resource "kubernetes_service_account" "efs_csi_driver_sa" {
  metadata {
    name      = "${var.efs_csi_driver_chart.name}-sa"
    namespace = "${var.efs_csi_driver_chart.namespace}"
    annotations = {
      "kubernetes.io/enforce-mountable-secrets" = "true"
    }
  }
}
