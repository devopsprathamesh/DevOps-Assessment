Deploy gitlab runner on K8s Cluster 

*** Pre-req [ Minikube / Rancher-Desktop ]

1. Minikube : https://minikube.sigs.k8s.io/docs/start/?arch=%2Fmacos%2Farm64%2Fstable%2Fbinary+download#Service
2. Rancher-Desktop : https://docs.rancherdesktop.io/getting-started/installation

***  https://github.com/devopsprathamesh/DevOps-Assessment/blob/main/MiniKube/**providers.tf**

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" ## depends on your k8 cluster setup where the kubeconfig file is configured
    config_context = "minikube" ##Cluster Context
  }
}

## gitlabagent for older version < 16.*.*
version    = "0.64.0"
<img width="556" alt="image" src="https://github.com/user-attachments/assets/bd08f93f-c786-4a0b-8048-ca1b3948d8d8">


## gitlabagent for newer version > 16.*.*
  set {
    name  = "image.tag"
    value = "v17.3.0"
    }
<img width="556" alt="image" src="https://github.com/user-attachments/assets/9f6a1cad-8b92-48bd-9020-d96cd39051b1">

Configurations : https://github.com/devopsprathamesh/DevOps-Assessment/blob/main/MiniKube/**values.yaml**

1. runnerRegistrationToken: "GR1348941jxqLynFNDj4Vy9qP6yxu" ## this token is used by runner for auth and registration and it is mandatory
2. rbac:
     create: true   ## so that gitlabrunner can control the cluster or namespace oprerations
     rules: 
   - resources: ["configmaps", "events", "pods", "pods/attach", "pods/exec", "secrets", "services"]
     verbs: ["get", "list", "watch", "create", "patch", "update", "delete"]
3. runners: ### Runner configuration for more you can visit **https://docs.gitlab.com/runner/configuration/advanced-configuration.html**
  config: |
    [[runners]]
      [runners.kubernetes]
        namespace = "{{.Release.Namespace}}"
        image = "alpine"
4.   tags: "pratham" ## Tag for runner so it can be assigned to respective jobs
5.   name: "myrunner" ## Runner name

**Once above all pre-req and configurations are done**

terraform init
terraform validate
terraform apply
<img width="821" alt="image" src="https://github.com/user-attachments/assets/7697a23e-ab6b-4699-b295-60d2814f0dca">


Post above the runner pods will be deployed and runner can be visible on dashboard
<img width="603" alt="image" src="https://github.com/user-attachments/assets/e1b976c5-b694-4c70-b94e-96d45bfb67c4">


