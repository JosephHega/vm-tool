using 'main.bicep'

param resourceGroupName = 'prod-rg'
param location = 'germanywestcentral'
param vmName = 'prod-vm'
param osType = 'Windows'
param addToExistingNetwork = true
param subnetId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/prod-rg/providers/Microsoft.Network/virtualNetworks/vnet-germanywestcentral/subnets/snet-germanywestcentral-1'
param createPublicIP = false

param osDiskSizeGB = 127
param osDiskType = 'Premium_LRS'
param imageReference = {
  publisher: 'MicrosoftWindowsServer'
  offer: 'WindowsServer'
  sku: '2022-Datacenter'
  version: 'latest'
}

param availabilityZoneMode = 'none'
param availabilityZones = []
param useHybridBenefit = true
param useSpotInstances = false
param vmSize = 'Standard_DS4_v2'

param adminUsername = 'prodadmin'
param adminPassword = 'ProdSecurePassword123!'
