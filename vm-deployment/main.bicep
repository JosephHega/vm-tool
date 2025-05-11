@description('The Azure region to deploy the VM')
param location string

@description('The name of the resource group (only for reference, not created)')
param resourceGroupName string

@description('The name of the virtual machine')
param vmName string

@description('Whether to attach the NIC to an existing network (true/false)')
param addToExistingNetwork bool

@description('The Subnet ID to attach the NIC to (Existing Subnet, required if addToExistingNetwork is true)')
param subnetId string

@description('The OS disk size in GB')
param osDiskSizeGB int = 128

@description('The OS disk type')
param osDiskType string = 'Premium_LRS'

@description('Image reference for the VM OS')
param imageReference object = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '20_04-lts-gen2'
  version: 'latest'
}

@description('Specify the availability zone mode (manual, auto, or none)')
param availabilityZoneMode string = 'none'

@description('Specify the availability zones (if manual)')
param availabilityZones array = []

@description('Use Azure Hybrid Benefit')
param useHybridBenefit bool = false

@description('Enable Azure Spot Instances (for Dev only)')
param useSpotInstances bool = false

@description('The admin username for the VM')
param adminUsername string = 'defaultuser'

@secure()
@description('The admin password for the VM')
param adminPassword string = 'SecurePassword123!'

@description('The VM size (Standard_DS1_v2, Standard_B2s, etc.)')
param vmSize string = 'Standard_DS1_v2'

// Automatically create a NIC and attach it to the specified Subnet (if addToExistingNetwork is true)
resource nic 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [{
      name: 'ipconfig1'
      properties: {
        subnet: addToExistingNetwork ? { id: subnetId } : null
        privateIPAllocationMethod: 'Dynamic'
      }
    }]
  }
}

// OS Disk Configuration
resource osDisk 'Microsoft.Compute/disks@2022-05-01' = {
  name: '${vmName}-osdisk'
  location: location
  properties: {
    creationData: {
      createOption: 'FromImage'
    }
    diskSizeGB: osDiskSizeGB
    sku: {
      name: osDiskType
    }
  }
}

// VM Resource Definition
resource vm 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: vmName
  location: location
  zones: availabilityZoneMode == 'manual' ? availabilityZones : (availabilityZoneMode == 'auto' ? null : [])

  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }

    storageProfile: {
      osDisk: {
        name: osDisk.name
        createOption: 'Attach'
        managedDisk: {
          id: osDisk.id
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
        id: nic.id
      }]
    }
  }
}
