using 'main.bicep'

param resourceGroupName = 'prod-rg'
param location = 'germanywestcentral'
param vmName = 'prod-vm'
param vnetId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/prod-rg/providers/Microsoft.Network/virtualNetworks/vnet-germanywestcentral'
param subnetId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/prod-rg/providers/Microsoft.Network/virtualNetworks/vnet-germanywestcentral/subnets/snet-germanywestcentral-1'

param osDiskSizeGB = 127
param osDiskType = 'Premium_LRS'
param imageReference = {
  publisher: 'RedHat'
  offer: 'RHEL'
  sku: '8-lvm-gen2'
  version: 'latest'
}

param enableTrustedLaunch = true  // Only if you want enhanced security (can be false for Linux)
param enableSecureBoot = false    // Not needed for Linux
param enableVTPM = false          // Not needed for Linux

param availabilityZoneMode = 'manual'
param availabilityZones = ['1']
param useHybridBenefit = false  // Hybrid Benefit is not applicable for RHEL
param useSpotInstances = false  // Not recommended for Production
param vmSize = 'Standard_DS1_v2'

param adminUsername = 'produser'
param adminPassword = 'ProdSecurePassword456!'
