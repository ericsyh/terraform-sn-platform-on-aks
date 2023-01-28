variable "host" {
  description = "Azure Kubernetes Service Cluster host"
}

variable "client_certificate" {
  description = "Azure Kubernetes Service Cluster client_certificate"
}

variable "client_key" {
  description = "Azure Kubernetes Service Cluster client_key"
}

variable "cluster_ca_certificate" {
  description = "Azure Kubernetes Service Cluster cluster_ca_certificate"
}

variable "operator_namespace" {
  description = "Azure Kubernetes namespace for operators"
}

variable "sn_platform_namespace" {
  description = "Azure Kubernetes namespace for sn-platform"
}