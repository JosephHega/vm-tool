using 'main.bicep'

param resourceGroupName = 'linuxVM-rg'
param location = 'germanywestcentral'
param vmName = 'linux-vm-new-test'
param osType = 'Linux'
param vmSize = 'Standard_DS4_v2'
param addToExistingNetwork = true
param subnetId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/prod-rg/providers/Microsoft.Network/virtualNetworks/vnet-germanywestcentral/subnets/snet-germanywestcentral-1'
param createPublicIP = false

param osDiskSizeGB = 127
param osDiskType = 'StandardSSD_LRS'  // Set to SSD


param imageReference = {
  publisher: 'RedHat'
  offer: 'RHEL'
  sku: '8-lvm-gen2'  
  version: 'latest'
}

param availabilityZoneMode = 'Manual'
param availabilityZones = ['1', '2']
param useHybridBenefit = false
param useSpotInstances = false


param adminUsername = 'prodadmin'
param adminPassword = 'ProdSecurePassword123!'
