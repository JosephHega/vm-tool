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

resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: vmName
  location: location
  identity: {
    type: 'SystemAssigned'

    // Uncomment below if you want to use a User Assigned Managed Identity (UAMI) later
    // type: 'SystemAssigned, UserAssigned'
    // userAssignedIdentities: {
    //   '/subscriptions/7e116fd0-ac3c-4bbd-81d4-78ff2da2fbe3/resourceGroups/amba-monitoring-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-amba-prod-001': {}
    // }
  }
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${vmName}_osdisk'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        deleteOption: 'Detach'
        diskSizeGB: osDiskSizeGB
      }
      dataDisks: []
    }
    // Uncomment licenseType if you want to use Azure Hybrid Benefit
    // licenseType: 'Windows_Server'

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
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
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
