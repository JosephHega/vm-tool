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
param nicId = '/subscriptions/your-subscription-id/resourceGroups/dev-rg/providers/Microsoft.Network/networkInterfaces/dev-nic'
param osDiskSizeGB = 30
param osDiskType = 'Standard_LRS'
param imageReference = {
  publisher: 'Canonical'
  offer: '0001-com-ubuntu-server-focal'
  sku: '20_04-lts'
  version: 'latest'
}

