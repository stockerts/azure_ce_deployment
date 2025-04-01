# Azure Deployment Guide

## Overview
This repository contains scripts and configuration files to deploy a Virtual Machine (VM) in Microsoft Azure using the Azure CLI. The deployment includes:
- A Public IP address
- A Virtual Network Interface Card (NIC)
- A VM with F5 XC CE image
- A cloud-init configuration for automated provisioning

## Project Structure
```
azure-deployment/
│── scripts/
│   ├── deploy-azure-resources.sh           # Main deployment script
│── configs/
│   ├── azure-vars.sh                       # Variables file
│── cloud-init/
│   ├── cloud-init.yaml                     # Cloud-init configuration
│── README.md                               # Documentation
```

## Prerequisites
Before running the deployment script, ensure you have:
- An active **Azure subscription**
- **Azure CLI** installed (`az` command available)
- Proper **permissions** to create resources in Azure
- A **SSH key pair** available for authentication

## Setup & Running the Deployment

### 1. Clone the Repository
```sh
git clone https://github.com/yourusername/azure-deployment.git
cd azure-deployment
```

### 2. Update the Variables
Modify the `configs/azure-vars.sh` file to match your environment.

```sh
#!/bin/bash

# Base resource name
BASE_NAME="your-ce-name"
NODE_NUM="01"

# Resource groups
CE_RESOURCE_GROUP="your-compute-resource-group"
VNET_RESOURCE_GROUP="your-network-resource-group"

# Networking
VNET_NAME="your-virtual-network-name"
SUBNET_NAME="your-subnet-name"
NET_SEC_GROUP="your-network-security-group"

# VM Configuration
AZ_VM_SIZE="Standard_D4as_v5"
ADMIN_NAME="your-admin-username"
SSH_KEY_NAME="your-ssh-key-name"
LOCATION="westus2"

# Cloud-init configuration
CLOUD_INIT_FILE="cloud-init/cloud-init.yaml"
```

### 3. Update Cloud-init Configuration (Optional)
Modify `cloud-init/cloud-init.yaml` to customize the VM initialization.

Example:
```yaml
#cloud-config
write_files:
  - path: /etc/vpm/user_data
    permissions: 644
    owner: root
    content: |
      token: your-token-number
      #slo_ip: Un-comment and set Static IP/mask for SLO if needed.
      #slo_gateway: Un-comment and set default gateway for SLO when static IP is needed.
```

### 4. Run the Deployment Script
Make sure the script is executable, then run it:
```sh
chmod +x scripts/deploy-azure-resources.sh
./scripts/deploy-azure-resources.sh
```

### 5. Verify Deployment
Once the script completes, check the Azure portal or use the Azure CLI to verify that the resources were created successfully.
```sh
az vm list -d --output table
```

## Troubleshooting
- If authentication fails, verify your Azure CLI login:
  ```sh
  az login
  ```
- If a resource already exists, modify `NODE_NUM` or delete existing resources:
  ```sh
  az group delete --name your-compute-resource-group --yes --no-wait
  ```
- Check the Azure activity logs for deployment errors in the portal.

## Next Steps
- **Automate** deployment with GitHub Actions
- **Integrate** with Terraform for Infrastructure as Code (IaC)

For any issues, please open an issue on GitHub!

---
© 2025 Your Company. All rights reserved.

