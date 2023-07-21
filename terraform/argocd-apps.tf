/* resource "argocd_application" "web_client" {
  metadata {
    name = "altin-assignment-4-api"
    #labels = []
    #annotations = []
  }
  wait = false

  spec {
    project = "altin"
    source {
      repo_url        = "https://github.com/altinhykolli/assignment-4-api.git"
      path            = "helm/api"
      target_revision = "main"

      helm {
        value_files = ["values.yaml"]
      }
    }

    destination {
      server    = local.eks_cluster_endpoint
      namespace = "altin"
    }

    sync_policy {
      automated {
        prune       = true
        self_heal   = true
        allow_empty = true
      }
    }
  }
} */