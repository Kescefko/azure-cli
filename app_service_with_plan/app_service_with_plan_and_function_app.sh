#!/bin/bash

# Variables
resourceSuffix=$RANDOM
webName="tailspin-space-game-web-${resourceSuffix}"
leaderboardName="tailspin-space-game-leaderboard-${resourceSuffix}"
storageName="tailspinspacegame${resourceSuffix}"
rgName="tailspin-space-game-rg"
planName="tailspin-space-game-asp"
region="polandcentral"

# Create resource group
echo "Creating resource group: $rgName"
az group create --name "$rgName" --location "$region"

# Create App Service Plan
echo "Creating App Service Plan: $planName"
az appservice plan create --name "$planName" --resource-group "$rgName" --sku B1 --is-linux --location "$region"

# Create Web App
echo "Creating Web App: $webName"
az webapp create --name "$webName" --resource-group "$rgName" --plan "$planName" --runtime "DOTNETCORE|6.0"

# Create Storage Account
echo "Creating Storage Account: $storageName"
az storage account create --name "$storageName" --resource-group "$rgName" --sku Standard_LRS --location "$region"

# Create Function App
echo "Creating Function App: $leaderboardName"
az functionapp create --name "$leaderboardName" --resource-group "$rgName" --storage-account "$storageName" --functions-version 4 --consumption-plan-location "$region"
