@description('Name of the Virtual Machine')
param vmName string

@description('Location of the VM')
param location string = 'germanywestcentral'

@description('Size of the VM')
param vmSize string = 'Standard_D2s_v5'

@description('Admin username')
param adminUsername string = 'adminuser'

@description('OS Disk size in GB')
param osDiskSizeGB int = 128

@description('Resource ID of the NIC to attach')
param nicId string

@description('Resource ID of the existing OS disk to attach')
param osDiskId string

resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: vmName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      osDisk: {
        osType: 'Windows'
        name: '${vmName}_OsDisk'
        createOption: 'Attach'
        caching: 'ReadWrite'
        managedDisk: {
          id: osDiskId
        }
        deleteOption: 'Detach'
        diskSizeGB: osDiskSizeGB
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicId
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}
