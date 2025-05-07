// prod.bicepparam
using 'main.bicep'
param enableTrustedLaunch = false
param availabilityZone = ''
param useHybridBenefit = true
param enableHostEncryption = false
param useSpotInstances = false
param adminUsername = 'produser'
param adminPassword = 'ProdSecurePassword456!'
param location = 'germanywestcentral'
param vmName = 'prod-vm'
param nicId = '/subscriptions/your-subscription-id/resourceGroups/prod-rg/providers/Microsoft.Network/networkInterfaces/prod-nic'
param osDiskSizeGB = 64
param osDiskType = 'Premium_LRS'
param imageReference = {
  publisher: 'Canonical'
  offer: '0001-com-ubuntu-server-focal'
  sku: '20_04-lts'
  version: 'latest'
}
