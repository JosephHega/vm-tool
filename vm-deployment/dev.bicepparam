// dev.bicepparam
using 'main.bicep'

param location = 'Germany West Central'
param vmName = 'dev-vm'
param nicId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/prod-rg/providers/Microsoft.Network/networkInterfaces/aw-prod-test-nic'
param osDiskSizeGB = 30
param osDiskType = 'Standard_LRS'
param enableTrustedLaunch = false
param useHybridBenefit = true
param enableHostEncryption = false
param useSpotInstances = true
param imageReference = {
  publisher: 'Canonical'
  offer: '0001-com-ubuntu-server-focal'
  sku: '20_04-lts'
  version: 'latest'
}
