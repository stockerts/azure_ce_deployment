#!/bin/bash

# Load variables from external file
source "$(dirname "$0")/../configs/azure-ce-vars.sh"

# Step 1: Create a Public IP
az network public-ip create \
  --resource-group "$CE_RESOURCE_GROUP" \
  --name "${BASE_NAME}-node${NODE_NUM}-pubip" \
  --allocation-method Static \
  --location "$LOCATION"

read -p "Public IP creation complete. Press Enter to continue..."

# Step 2: Retrieve the Subnet ID
SUBNET_ID=$(az network vnet subnet show \
  --resource-group "$VNET_RESOURCE_GROUP"  \
  --vnet-name "$VNET_NAME" \
  --name "$SUBNET_NAME" \
  --query "id" --output tsv)

read -p "Subnet ID lookup complete. Press Enter to continue..."

# Step 3: Create a Network Interface Card (NIC)
az network nic create \
  --resource-group "$CE_RESOURCE_GROUP" \
  --name "${BASE_NAME}-node${NODE_NUM}-nic" \
  --subnet "$SUBNET_ID" \
  --public-ip-address "${BASE_NAME}-node${NODE_NUM}-pubip" \
  --network-security-group "$NET_SEC_GROUP" \
  --location "$LOCATION"

read -p "Network Interface creation complete. Press Enter to continue..."

# Step 4: Accept the F5 Distributed Cloud CE BYOL image terms
az vm image terms accept --publisher f5-networks --offer f5-distributed-cloud-ce-byol --plan ce-x64-gen2

# Step 5: Create the VM
az vm create \
  --resource-group "$CE_RESOURCE_GROUP" \
  --name "${BASE_NAME}-node${NODE_NUM}" \
  --image f5-networks:f5xc_customer_edge:f5xccebyol:latest \
  --plan-name f5xccebyol \
  --plan-product f5xc_customer_edge \
  --plan-publisher f5-networks \
  --size "$AZ_VM_SIZE" \
  --admin-username "$ADMIN_NAME" \
  --authentication-type ssh \
  --ssh-key-name "$SSH_KEY_NAME" \
  --nics "${BASE_NAME}-node${NODE_NUM}-nic" \
  --location "$LOCATION" \
  --custom-data @"$CLOUD_INIT_FILE"
