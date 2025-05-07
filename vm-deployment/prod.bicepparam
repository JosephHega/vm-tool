// prod.bicepparam
using 'main.bicep'

param location = 'westeurope'
param vmName = 'prod-vm'
param nicId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/prod-rg/providers/Microsoft.Network/networkInterfaces/aw-prod-test-nic'
param osDiskSizeGB = 30
param osDiskType = 'Standard_LRS'
param enableTrustedLaunch = false
param useHybridBenefit = true
param enableHostEncryption = false
param useSpotInstances = false
param imageReference = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '20_04-lts-gen2'
  version: 'latest'
}
