
using 'main.bicep'

param location = 'westeurope'
param vmName = 'dev-vm'
param addToExistingNetwork = true
param subnetId = '<your-subnet-id>'
param osDiskSizeGB = 30
param osDiskType = 'Standard_LRS'
param imageReference = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '20_04-lts-gen2'
  version: 'latest'
}

param vmSize = 'Standard_B2s'
param adminUsername = 'devuser'
param adminPassword = 'DevStrongPassword123!'
