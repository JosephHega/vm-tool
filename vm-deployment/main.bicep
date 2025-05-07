// main.bicep

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

@description('Image reference for the VM OS')
param imageReference object = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '20_04-lts-gen2'
  version: 'latest'
}

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
    networkProfile: {
      networkInterfaces: [{
        id: nicId
      }]
    }
  }
}
