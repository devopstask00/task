

### Pre-requisites

* Terraform CLI installed.
* AWS credentials configured.
* kubectl installed.
* helm installed.

### Deployment Instructions
* Clone this repository
* Edit terraform.tfvars to match your values.
* Run a terraform init to grab providers and modules.
* Run a terraform plan to view the plan.
* Run a terraform_apply and wait 15 - 20 minutes. 
>Note: If it fails for HTTP timeout while waiting to apply the Helm chart, retry terraform_apply
* Run aws eks --region us-west-2 update-kubeconfig --name dev-cluster to add the cluster context to your kubeconfig.
* Run kubectl get pods -A to check the pods
* Run kubectl get svc -A to check the services
* Run kubectl apply -f ./kubernetes_yaml_files/grafanaingress.yaml
* Run kubectl apply -f ./kubernetes_yaml_files/jenkinsingress.yaml
* Run kubectl apply -f ./kubernetes_yaml_files/lokiingress.yaml
* Run kubectl apply -f ./kubernetes_yaml_files/mysql-pv.yaml
* Run kubectl apply -f ./kubernetes_yaml_files/mysql-deployment.yaml
* Run kubectl apply -f ./kubernetes_yaml_files/prometheusingress.yaml
* Run kubectl get ing -A to see the urls poining to ingress and applications
* Run helm upgrade --install loki grafana/loki-stack --set grafana.enabled=true
* Create CNAME for each of the HOSTS and ADDRESSES you received from previous command
* now you can access the applications with through the cnames created
* Log in jenkins with the credentials you set in  terraform.tfvars.
* to access grafana-loki stack use below command to retreive password
	kubectl get secret --namespace default loki-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo



### Connecting
* Run aws eks --region us-east-1 update-kubeconfig --name dev-cluster to add the context to your kubeconfig file.

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.2.6 |

## Providers

| Name | Version |
|------|---------|
| aws | 4.21.0 |
| helm | 2.6.0 |
| kubernetes | 2.12.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| my-cluster | terraform-aws-modules/eks/aws | 18.28.0 |


### Notes

--------
use below command to see if the load balancer is working properly:
	kubectl logs -f -n kube-system -l app.kubernetes.io/name=aws-load-balancer-controller
--------

