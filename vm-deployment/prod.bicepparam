using './main.bicep'

param vmName = 'aw0008'
param osDiskId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourcegroups/prod-rg/providers/Microsoft.Compute/disks/aw-prod-test-osdisk'
param nicId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/prod-rg/providers/Microsoft.Network/networkInterfaces/aw-prod-test-nic'
param location = 'germanywestcentral'
param vmSize = 'Standard_B1ls'
param adminUsername = 'skfadmin'
param osDiskSizeGB = 64
