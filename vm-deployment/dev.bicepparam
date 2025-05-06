using './main.bicep'

param vmName = 'aw-dev-0001'
param osDiskId = '/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/dev-rg/providers/Microsoft.Compute/disks/aw-dev-0001-osdisk'
param nicId = '/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/dev-rg/providers/Microsoft.Network/networkInterfaces/aw-dev-0001-nic'
param location = 'westeurope'
param vmSize = 'Standard_D2s_v5'
param adminUsername = 'devadmin'
param osDiskSizeGB = 128
param availabilityZone = '1'
param useSpot = true
param evictionPolicy = 'Deallocate'
param useHybridBenefit = true
param dataDisks = [
  {
    sizeGB: 64
    caching: 'ReadOnly'
    type: 'StandardSSD_LRS'
  }
]
