provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    config_context = "minikube"
  }
}


resource "helm_release" "gitlabrunner-agent11" {
  name       = "mygitlab-runner1"
  repository = "https://charts.gitlab.io"
  chart      = "gitlab-runner"
  version    = "0.64.0"

values = [
    "${file("./values.yaml")}"
  ]

}

