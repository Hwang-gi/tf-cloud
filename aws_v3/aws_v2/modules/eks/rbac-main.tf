resource "kubernetes_cluster_role" "frontend_backend_monitoring_pods_services" {
  metadata {
    name      = "frontend-backend-monitoring-pods-services"
  }

  rule {
    verbs     = ["get", "list"]
    api_groups = [""]
    resources  = ["pods", "services"]
  }
}

resource "kubernetes_cluster_role" "frontend_backend_pods" {
  metadata {
    name      = "frontend-backend-pods"
  }

  rule {
    verbs     = ["create", "update", "delete"]
    api_groups = [""]
    resources  = ["pods"]
  }
}

resource "kubernetes_cluster_role" "frontend_backend_deployments" {
  metadata {
    name      = "frontend-backend-deployments"
  }

  rule {
    verbs     = ["get", "list", "create", "update", "delete"]
    api_groups = ["apps"]
    resources  = ["deployments"]
  }
}

resource "kubernetes_cluster_role" "backend_persistent_volumes" {
  metadata {
    name      = "backend-persistent-volumes"
  }

  rule {
    verbs     = ["get", "list", "create"]
    api_groups = ["storage.k8s.io"]
    resources  = ["persistentvolumes", "persistentvolumeclaims"]
  }
}

# You can now bind these roles to specific users or service accounts

resource "kubernetes_cluster_role_binding" "frontend_backend_monitoring_pods_services_binding" {
  metadata {
    name      = "frontend-backend-monitoring-pods-services-binding"
    
  }

  subject {
    kind      = "User"
    name      = "git-user"
  }

  role_ref {
    kind    = "ClusterRole"
    name     = kubernetes_cluster_role.frontend_backend_monitoring_pods_services.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_cluster_role_binding" "frontend_backend_pods_binding" {
  metadata {
    name      = "frontend-backend-pods-binding"   
  }

  subject {
    kind      = "User"
    name      = "git-user"
  }

  role_ref {
    kind    = "ClusterRole"
    name     = kubernetes_cluster_role.frontend_backend_pods.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_cluster_role_binding" "frontend_backend_deployments_binding" {
  metadata {
    name      = "frontend-backend-deployments-binding"
  }

  subject {
    kind      = "User"
    name      = "git-user"
  }

  role_ref {
    kind    = "ClusterRole"
    name     = kubernetes_cluster_role.frontend_backend_deployments.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_cluster_role_binding" "backend_persistent_volumes_binding" {
  metadata {
    name      = "backend-persistent-volumes-binding"
  }

  subject {
    kind      = "User"
    name      = "git-user" 
  }

  role_ref {
    kind    = "ClusterRole"
    name     = kubernetes_cluster_role.backend_persistent_volumes.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_cluster_role" "user_group_ci_cd" {
  metadata {
    name = "ci-cd-group-user-group"
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "git_user_binding" {
  metadata {
    name = "git-user-binding"
  }

  subject {
    kind      = "User"
    name      = "git-user"
    api_group = "rbac.authorization.k8s.io"
  }

  role_ref {
    kind     = "ClusterRole"
    name     = kubernetes_cluster_role.user_group_ci_cd.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}

