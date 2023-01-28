# terraform-sn-platform-on-aks

## Introduction

This repo levarages [terraform](https://www.terraform.io/) to automate with below processes with a single terraform command: 
1. Provision an [AKS](https://azure.microsoft.com/en-us/products/kubernetes-service/) cluster
2. Configure the AKS cluster connection
3. Install the [vault-operator](https://github.com/banzaicloud/bank-vaults/tree/main/charts/vault-operator), [pulsar-operator](https://github.com/streamnative/charts/tree/master/charts/pulsar-operator) and [sn-platform](https://github.com/streamnative/charts/tree/master/charts/sn-platform) charts
4. Expose the StreamNative Console and Grafana with LoadBalancer

## Prerequisites

### Azure CLI

1. Install Azure CLI

```
brew install azure-cli
```

2. Login into Azure by running

```
az login
```

### Create an Active Directory service principal account

1. Use Azure CLI to create

```
az ad sp create-for-rbac --skip-assignment
```

Output:

```
{
  "appId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
  "displayName": "azure-cli-2019-04-11-00-46-05",
  "name": "http://azure-cli-2019-04-11-00-46-05",
  "password": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
  "tenant": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
}
```

2. Keep the `appId` and `password`

### Terraform CLI

1. Install Terraform CLI

```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

## How to use

1. Clone this repo

```
git clone https://github.com/ericsyh/terraform-sn-platform-on-aks.git
cd terraform-sn-platform-on-aks
```

2. Paste the `appId` and `password` in the `terraform.tfvars` file

3. Modify the `snp.yaml` to change the values configure you need. 

4. Run the terraform commands to initialize and execute: 

```
terraform init
terraform apply --auto-approve
```

5. Configure your AKS cluster to your local `kubectl`:

```
az aks get-credentials --resource-group $(terraform output -raw resource_group_name) --name $(terraform output -raw kubernetes_cluster_name)
```