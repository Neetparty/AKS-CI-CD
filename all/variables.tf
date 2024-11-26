variable "resource_group_name" {
  type = string
  default = ""
}

variable "location" {
  type = string
  default = "eastus"
}

variable "acr_name" {
  type = string
  default = ""
}

variable "aks_name" {
  type = string
  default = ""
}

variable "node_count" {
  type = number
  default = 3
}

variable "kubernetes_version" {
  type = string
  default = "1.30.5"
}

variable "istio_version" {
  type = string
  default = "1.24.0"
}

variable "istio_namespace" {
  type = string
  default = "istio-system"
}

variable "subscription_id" {
  type = string
}