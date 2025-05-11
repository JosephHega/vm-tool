using 'main.bicep'

param resourceGroupName = 'prod-rg'
param location = 'germanywestcentral'
param vmName = 'linux-prod'
param addToExistingNetwork = false
param subnetId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/prod-rg/providers/Microsoft.Network/virtualNetworks/vnet-germanywestcentral/subnets/snet-germanywestcentral-1'

param osDiskSizeGB = 256
param osDiskType = 'Premium_LRS'
param imageReference = {
  publisher: 'RedHat'
  offer: 'RHEL'
  sku: '8-lvm-gen2'
  version: 'latest'
}

param availabilityZoneMode = 'none'
param availabilityZones = []
param useHybridBenefit = false
param useSpotInstances = false
param vmSize = 'Standard_DS4_v2'

param adminUsername = 'produser'
param adminPassword = 'SecurePassword123!'
