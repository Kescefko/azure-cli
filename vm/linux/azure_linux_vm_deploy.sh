#!/bin/bash

# Prompt the user for the admin username
read -p "Enter the admin username for the VM: " admin_username

# Create the Azure VM with the entered username
az vm create \
    --name MyLinuxAgent \
    --resource-group gr-gyorgy-tailspin-dev-weu \
    --location westeurope \
    --image canonical:0001-com-ubuntu-server-focal:20_04-lts:latest \
    --size Standard_DS2_v2 \
    --admin-username "$admin_username" \
    --generate-ssh-keys


IPADDRESS=$(az vm show --name MyLinuxAgent --resource-group gr-gyorgy-tailspin-dev-weu --show-details --query [publicIps] --output tsv)
