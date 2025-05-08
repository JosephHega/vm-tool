@description('The Azure region to deploy the VM')
param location string

@description('The name of the resource group (only for reference, not created)')
param resourceGroupName string

@description('The name of the virtual machine')
param vmName string

@description('The existing NIC ID to attach to the VM')
param nicId string

@description('The OS disk size in GB')
param osDiskSizeGB int

@description('The OS disk type')
param osDiskType string

@description('Image reference for the VM OS')
param imageReference object

@description('Enable Trusted Launch (Secure Boot, vTPM)')
param enableTrustedLaunch bool

@description('Enable Secure Boot (only if Trusted Launch is enabled)')
param enableSecureBoot bool

@description('Enable vTPM (only if Trusted Launch is enabled)')
param enableVTPM bool

@description('Enable Host-based encryption')
param enableHostEncryption bool

@description('Specify the availability zone mode (manual, auto, or none)')
param availabilityZoneMode string

@description('Specify the availability zones (if manual)')
param availabilityZones array

@description('Use Azure Hybrid Benefit')
param useHybridBenefit bool

@description('Enable Azure Spot Instances (for Dev only)')
param useSpotInstances bool

@description('The admin username for the VM')
param adminUsername string

@secure()
@description('The admin password for the VM')
param adminPassword string

@description('The VM size (Standard_DS1_v2, Standard_B2s, etc.)')
param vmSize string

resource vm 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: vmName
  location: location
  zones: availabilityZoneMode == 'manual' ? availabilityZones : (availabilityZoneMode == 'auto' ? null : [])

  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    securityProfile: enableTrustedLaunch ? {
      securityType: 'TrustedLaunch'
      uefiSettings: {
        secureBootEnabled: enableSecureBoot
        vTpmEnabled: enableVTPM
      }
      encryptionAtHost: enableHostEncryption
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
