using 'main.bicep'

param resourceGroupName = 'prod-rg'
param location = 'germanywestcentral'
param vmName = 'prod-vm'
param nicId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/prod-rg/providers/Microsoft.Network/networkInterfaces/prod-nic'

param osDiskSizeGB = 127
param osDiskType = 'Premium_LRS'
param imageReference = {
  publisher: 'MicrosoftWindowsServer'
  offer: 'WindowsServer'
  sku: '2022-Datacenter-smalldisk-g2'
  version: 'latest'
}

param enableTrustedLaunch = true
param enableSecureBoot = true
param enableVTPM = true
param enableHostEncryption = true
param availabilityZoneMode = 'manual'
param availabilityZones = ['1', '2']
param useHybridBenefit = true
param useSpotInstances = false
param vmSize = 'Standard_DS1_v2'

param adminUsername = 'produser'
param adminPassword = 'ProdStrongPassword456!'
