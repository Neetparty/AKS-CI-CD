# Terraform AKS Infrastructure with Istio and ArgoCD

This project provides Terraform code to deploy a complete AKS (Azure Kubernetes Service) infrastructure, including:

- **AKS Cluster:** A basic AKS cluster with a configurable number of nodes and Kubernetes version.
- **Azure Container Registry (ACR):**  For storing and managing Docker images.
- **Istio Service Mesh:** For traffic management, security, and observability.
- **ArgoCD:** For declarative continuous deployment.

## Architecture

The Terraform code will provision the following resources in Azure:

- Resource Group
- Azure Container Registry (ACR)
- AKS Cluster
- Istio Service Mesh (installed via Helm)
- ArgoCD (installed via Helm)

## Prerequisites

- **Azure Account:** An active Azure subscription.
- **Terraform:** Installed and configured on your local machine.
- **Azure CLI:** Installed and authenticated to your Azure subscription.
- **Kubectl:** Installed and configured to interact with your AKS cluster.

## Usage

1. **Clone this repository:** `git clone https://github.com/your-username/your-repo.git`
2. **Configure variables:** Update the `variables.tf` file with your desired values for resource names, location, node count, Kubernetes version, etc.
3. **Initialize Terraform:** `terraform init`
4. **Plan the deployment:** `terraform plan`
5. **Apply the changes:** `terraform apply`

## Key Features

- **Modular Structure:** The code is organized into separate modules for AKS, ACR, Istio, and ArgoCD, making it easy to manage and customize.
- **Automated ACR Integration:** The AKS cluster is automatically configured to use the provisioned ACR.
- **Istio Installation:** Istio is installed using Helm charts, providing a streamlined and repeatable deployment process.
- **ArgoCD Integration:** ArgoCD is deployed to enable GitOps-based continuous delivery.
- **Resource Cleanup:**  Running `terraform destroy` will remove all provisioned resources.

## Customization

- **Node Configuration:** Modify the `aks.tf` file to adjust the node count, VM size, and other node pool settings.
- **Istio Configuration:** Customize the Istio installation by modifying the `istio.tf` file and providing custom Helm values.
- **ArgoCD Configuration:**  Adjust the ArgoCD deployment by editing the `argocd.tf` file and providing custom Helm values.

## Notes

- Ensure that the Azure CLI is authenticated to your Azure subscription before running Terraform.
- The `null_resource` blocks in `aks.tf` use the Azure CLI to attach ACR to AKS and update the kubeconfig. 
- This project assumes you have basic familiarity with Terraform, Kubernetes, Istio, and ArgoCD.

## Disclaimer

* This project is under development and subject to change.
* You should customize the CI/CD pipeline to fit your specific needs.

## Contributors

* [Neetparty](https://github.com/Neetparty)

## License

[MIT](./LICENSE)
