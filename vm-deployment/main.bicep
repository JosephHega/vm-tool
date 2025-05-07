@description('The Azure region to deploy the VM')
param location string

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
  publisher: 'Canonical'
  offer: '0001-com-ubuntu-server-focal'
  sku: '20_04-lts'
  version: 'latest'
}

@description('Enable Trusted Launch (Secure Boot, vTPM, Integrity Monitoring)')
param enableTrustedLaunch bool = false

@description('Specify the availability zone (optional)')
param availabilityZone string = ''

@description('Use Azure Hybrid Benefit (default true)')
param useHybridBenefit bool = true

@description('Enable Host-based encryption')
param enableHostEncryption bool = false

@description('Enable Azure Spot Instances (for Dev only)')
param useSpotInstances bool = true

@description('The admin username for the VM')
param adminUsername string

@description('The admin password for the VM')
param adminPassword string

resource vm 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s' // Cheapest VM size
    }
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
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }
    networkProfile: {
      networkInterfaces: [{
        id: nicId
      }]
    }
  }
}
