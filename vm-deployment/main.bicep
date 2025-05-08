@description('The Azure region to deploy the VM')
param location string

@description('The name of the resource group (only for reference, not created)')
param resourceGroupName string

@description('The name of the virtual machine')
param vmName string

@description('The existing NIC ID to attach to the VM')
param nicId string

@description('The OS disk size in GB')
param osDiskSizeGB int = 30

@description('The OS disk type')
param osDiskType string = 'Standard_LRS'

@description('Image reference for the VM OS')
param imageReference object = {
  publisher: 'MicrosoftWindowsServer'
  offer: 'WindowsServer'
  sku: '2022-Datacenter-smalldisk-g2'
  version: 'latest'
}

@description('Enable Trusted Launch (Secure Boot, vTPM, Integrity Monitoring)')
param enableTrustedLaunch bool = true

@description('Specify the availability zone (optional)')
param availabilityZone string = '1'

@description('Use Azure Hybrid Benefit (default true)')
param useHybridBenefit bool = true

@description('Enable Host-based encryption')
param enableHostEncryption bool = false

@description('Enable Azure Spot Instances (for Dev only)')
param useSpotInstances bool = true

@description('The admin username for the VM')
param adminUsername string

@secure()
@description('The admin password for the VM')
param adminPassword string

resource vm 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: vmName
  location: location
  zones: availabilityZone != '' ? [availabilityZone] : null
  properties: {
    hardwareProfile: {
      vmSize: useSpotInstances ? 'Standard_B1s' : 'Standard_D2s_v3'
    }
    securityProfile: enableTrustedLaunch ? {
      securityType: 'TrustedLaunch'
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
    } : null
    
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        diskSizeGB: osDiskSizeGB
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
      imageReference: imageReference
    }
    
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        enableAutomaticUpdates: true
      }
    }
    
    networkProfile: {
      networkInterfaces: [{
        id: nicId
      }]
    }
    
    licenseType: useHybridBenefit ? 'Windows_Server' : null
  }
}
