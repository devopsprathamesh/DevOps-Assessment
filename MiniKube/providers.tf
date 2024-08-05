provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    config_context = "minikube"
  }
}

## gitlabagent for older version < 16.*.*
resource "helm_release" "gitlabrunner-agent11" {
  name       = "mygitlab-runner1"
  namespace  = "gitlab-agent-minikubeagent"
  create_namespace = true
  
  repository = "https://charts.gitlab.io"
  chart      = "gitlab-runner"
  version    = "0.64.0"
values = [
    "${file("./values.yaml")}"
  ]
  set {
    name  = "config.token"
    value = "glagent-ZqBiRs4DoMJZCAuXxHfVZg3fo5YHs6m6KrQXqznmAf_WDi2Dsg"
    }
  set {
    name  = "config.kasAddress"
    value = "wss://kas.gitlab.com"
    }
}

#resource "helm_release" "kubecluster-agent1" {
#  name       = "mykubecluster-agent1"
#  namespace  = "gitlab-agent-minikubeagent"
#  repository = "https://charts.gitlab.io"
#  chart      = "gitlab-runner"
#  create_namespace = true
#  set {
#    name  = "image.tag"
#    value = "v17.3.0"
#    }
#  set {
#    name  = "config.token"
#    value = "glagent-ZqBiRs4DoMJZCAuXxHfVZg3fo5YHs6m6KrQXqznmAf_WDi2Dsg"
#    }
#  set {
#    name  = "config.kasAddress"
#    value = "wss://kas.gitlab.com"
#    }
#}
