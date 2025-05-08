// dev.bicepparam
using 'main.bicep'
param enableTrustedLaunch = false
param availabilityZone = ''
param useHybridBenefit = true
param enableHostEncryption = false
param useSpotInstances = true
param adminUsername = 'devuser'
param adminPassword = 'DevStrongPassword123!'
param location = 'germanywestcentral'
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

