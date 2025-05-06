@description('Name of the Virtual Machine')
param vmName string

@description('Resource ID of the OS disk')
param osDiskId string

@description('Resource ID of the NIC')
param nicId string

@description('Location of the VM')
param location string = 'germanywestcentral'

@description('Availability Zone (e.g. "1", "2", "3")')
@allowed([
  ''
  '1'
  '2'
  '3'
])
param availabilityZone string = ''

@description('Size of the VM')
param vmSize string = 'Standard_D4lds_v5'

@description('Admin username')
param adminUsername string = 'admin'

@description('OS Disk size in GB')
param osDiskSizeGB int = 128

@description('Use Spot Instance pricing')
param useSpot bool = false

@description('Spot Eviction Policy (defaults to Deallocate)')
@allowed([
  'Deallocate'
  'Delete'
])
param evictionPolicy string = 'Deallocate'

@description('Use Hybrid Benefit (Windows license)')
param useHybridBenefit bool = true

@description('Optional data disks')
param dataDisks array = []

resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: vmName
  location: location
  zones: empty(availabilityZone) ? null : [availabilityZone]
  identity: {
    type: 'SystemAssigned, UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/7e116fd0-ac3c-4bbd-81d4-78ff2da2fbe3/resourceGroups/amba-monitoring-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-amba-prod-001': {}
    }
  }
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    priority: useSpot ? 'Spot' : 'Regular'
    evictionPolicy: useSpot ? evictionPolicy : null
    licenseType: useHybridBenefit ? 'Windows_Server' : null
    additionalCapabilities: {
      hibernationEnabled: false
    }
    securityProfile: {
      securityType: 'TrustedLaunch'
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
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
        name: '${vmName}_OsDisk'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: osDiskId
        }
        deleteOption: 'Detach'
        diskSizeGB: osDiskSizeGB
        securityProfile: {
          encryptionAtHost: true
        }
      }
      dataDisks: [for (disk, i) in dataDisks: {
        lun: i
        createOption: 'Empty'
        diskSizeGB: disk.sizeGB
        caching: disk.caching
        managedDisk: {
          storageAccountType: disk.type
        }
      }]
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
