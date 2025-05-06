using './main.bicep'

param vmName = 'aw-prod-0001'
param osDiskId = '/subscriptions/22222222-2222-2222-2222-222222222222/resourceGroups/prod-rg/providers/Microsoft.Compute/disks/aw-prod-0001-osdisk'
param nicId = '/subscriptions/22222222-2222-2222-2222-222222222222/resourceGroups/prod-rg/providers/Microsoft.Network/networkInterfaces/aw-prod-0001-nic'
param location = 'germanywestcentral'
param vmSize = 'Standard_D4lds_v5'
param adminUsername = 'skfadmin'
param osDiskSizeGB = 128
param availabilityZone = '2'
param useSpot = false
param evictionPolicy = 'Deallocate'
param useHybridBenefit = true
param dataDisks = []
