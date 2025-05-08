using 'main.bicep'

param resourceGroupName = 'dev-rg'
param location = 'westeurope'
param vmName = 'dev-vm'
param nicId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/prod-rg/providers/Microsoft.Network/networkInterfaces/aw-prod-test-nic'

param osDiskSizeGB = 30
param osDiskType = 'Standard_LRS'
param imageReference = {
  publisher: 'MicrosoftWindowsServer'
  offer: 'WindowsServer'
  sku: '2022-Datacenter-smalldisk-g2'
  version: 'latest'
}

param enableTrustedLaunch = true
param enableSecureBoot = true
param enableVTPM = true
param availabilityZoneMode = 'none'
param availabilityZones = []
param useHybridBenefit = true
param useSpotInstances = true
param vmSize = 'Standard_B2s'

param adminUsername = 'devuser'
param adminPassword = 'DevStrongPassword123!'
