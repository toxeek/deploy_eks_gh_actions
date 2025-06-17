# deploy_eks_gh_actions
Deploy EKS with Github Actions

Based on Nico Singh's tf code @ [Gitlab repo](https://gitlab.com/nicosingh/medium-deploy-eks-cluster-using-terraform).

## setup
You'll need to setup the Github Environments accordingly, each with its own AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY secrets, and for uat and production you should get some reviewer/s on. You'll also need changing the values in the tfvars files. This configuration is set for eu-west-1. make sure you change the setting for your requirements in the backend.tfvars, the tfvars, deploy.yml and terraform.tf files.


(under development)
