using 'main.bicep'

param location = 'germanywestcentral'
param vmName = 'test-linux-prod'
param addToExistingNetwork = false
param subnetId = '<your-subnet-id>'
param osDiskSizeGB = 256
param osDiskType = 'Premium_LRS'
param imageReference = {
  publisher: 'RedHat'
  offer: 'RHEL'
  sku: '8-lvm-gen2'
  version: 'latest'
}
param vmSize = 'Standard_DS4_v2'
param adminUsername = 'produser'
param adminPassword = 'SecurePassword123!'
