@description('Name of the Virtual Machine')
param vmName string = 'aw0008'

@description('Location of the VM')
param location string = 'germanywestcentral'

@description('Size of the VM')
param vmSize string = 'Standard_D4lds_v5'

@description('Admin username')
param adminUsername string = 'skfadmin'

@description('OS Disk size in GB')
param osDiskSizeGB int = 127

@description('NIC resource ID to attach')
param nicId string

@description('OS Disk resource ID to attach')
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
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      osDisk: { 
        osType: 'Windows'
        name: '${vmName}_osdisk'
        createOption: 'Attach' 
        caching: 'ReadWrite'
        managedDisk: {
          id: osDiskId 
        }
        deleteOption: 'Detach'
        diskSizeGB: osDiskSizeGB
      }
      dataDisks: []
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      allowExtensionOperations: true
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
