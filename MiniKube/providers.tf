provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    config_context = "minikube"
  }
}


resource "helm_release" "gitlabrunner-agent" {
  name       = "mygitlab-runner"
  repository = "https://charts.gitlab.io"
  chart      = "gitlab-runner"
  version    = "0.67.1"
  namespace  = "testdev"

values = [
    "${file("./values.yaml")}"
  ]

}

