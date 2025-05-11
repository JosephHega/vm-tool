using 'main.bicep'

param resourceGroupName = 'dev-rg'
param location = 'westeurope'
param vmName = 'dev-vm'
param addToExistingNetwork = true
param subnetId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/dev-rg/providers/Microsoft.Network/virtualNetworks/dev-vnet/subnets/default'

param osDiskSizeGB = 30
param osDiskType = 'Standard_LRS'
param imageReference = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '20_04-lts-gen2'
  version: 'latest'
}

param availabilityZoneMode = 'none'
param availabilityZones = []
param useHybridBenefit = false
param useSpotInstances = true
param vmSize = 'Standard_B2s'

param adminUsername = 'devuser'
param adminPassword = 'DevStrongPassword123!'
