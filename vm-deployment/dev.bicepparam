using 'main.bicep'

param resourceGroupName = 'dev-rg'
param location = 'westeurope'
param vmName = 'dev-vm'
param vnetId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/dev-rg/providers/Microsoft.Network/virtualNetworks/dev-vnet'
param subnetId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/dev-rg/providers/Microsoft.Network/virtualNetworks/dev-vnet/subnets/default'

param osDiskSizeGB = 30
param osDiskType = 'Standard_LRS'
param imageReference = {
  publisher: 'RedHat'
  offer: 'RHEL'
  sku: '8-lvm-gen2'
  version: 'latest'
}

param enableTrustedLaunch = false
param enableSecureBoot = false  // Secure Boot is not typically needed for Linux
param enableVTPM = false        // vTPM is not typically needed for Linux

param availabilityZoneMode = 'none'
param availabilityZones = []
param useHybridBenefit = false  // Hybrid Benefit is not applicable for RHEL
param useSpotInstances = true   // Spot Instances for Dev
param vmSize = 'Standard_B2s'

param adminUsername = 'devuser'
param adminPassword = 'DevStrongPassword123!'
