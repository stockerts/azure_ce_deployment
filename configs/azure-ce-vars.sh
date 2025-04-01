#!/bin/bash

# Base resource name
BASE_NAME="base-ce-name"
NODE_NUM="01"

# Resource groups
CE_RESOURCE_GROUP="compute-resource-group"
VNET_RESOURCE_GROUP="network-resource-group"

# Networking
VNET_NAME="virtual-network-name"
SUBNET_NAME="subnet-name"
NET_SEC_GROUP="network-security-group-name"

# VM Configuration
AZ_VM_SIZE="vm-size"
ADMIN_NAME="admin-username"
SSH_KEY_NAME="ssh-key-name"
LOCATION="azure-region"

# Cloud-init configuration
CLOUD_INIT_FILE="cloud-init/cloud-init.yaml"