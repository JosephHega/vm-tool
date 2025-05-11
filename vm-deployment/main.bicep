@description('The Azure region to deploy the VM')
param location string

@description('The name of the resource group (only for reference, not created)')
param resourceGroupName string

@description('The name of the virtual machine')
param vmName string

@description('Specify the OS type (Windows or Linux)')
param osType string

@description('Whether to attach the NIC to an existing network (true/false)')
param addToExistingNetwork bool

@description('The Subnet ID to attach the NIC to (Existing Subnet, required if addToExistingNetwork is true)')
param subnetId string

@description('Whether to create a Public IP (true/false)')
param createPublicIP bool = false

@description('The OS disk size in GB')
param osDiskSizeGB int

@description('The OS disk type (StandardSSD_LRS, Premium_LRS, Premium_ZRS)')
param osDiskType string = 'StandardSSD_LRS'

@description('Image reference for the VM OS')
param imageReference object

@description('Specify the availability zone mode (manual, auto, or none)')
param availabilityZoneMode string = 'none'

@description('Specify the availability zones (if manual)')
param availabilityZones array = []

@description('Use Azure Hybrid Benefit')
param useHybridBenefit bool = false

@description('Enable Azure Spot Instances (for Dev only)')
param useSpotInstances bool = false

@description('The admin username for the VM')
param adminUsername string

@secure()
@description('The admin password for the VM')
param adminPassword string

@description('The VM size (Standard_DS1_v2, Standard_B2s, etc.)')
param vmSize string

// Optional Public IP (Dynamic if created)
resource publicIP 'Microsoft.Network/publicIPAddresses@2022-09-01' = if (createPublicIP) {
  name: '${vmName}-publicIP'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

// Network Interface Configuration
resource nic 'Microsoft.Network/networkInterfaces@2022-09-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [{
      name: 'ipconfig1'
      properties: {
        subnet: addToExistingNetwork ? { id: subnetId } : null
        privateIPAllocationMethod: 'Dynamic'
        publicIPAddress: createPublicIP ? { id: publicIP.id } : null
      }
    }]
  }
}

// VM Resource Definition
resource vm 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: vmName
  location: location
  zones: availabilityZoneMode == 'manual' ? availabilityZones : null

  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }

    storageProfile: {
      imageReference: imageReference
      osDisk: {
        name: '${vmName}-osdisk'
        createOption: 'FromImage'
        diskSizeGB: osDiskSizeGB
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
      dataDisks: [
        {
          lun: 0
          name: '${vmName}-datadisk-1'
          createOption: 'Empty'
          diskSizeGB: 256  // Set your value directly here
          managedDisk: {
            storageAccountType: osDiskType
          }
        }
      ]
    }

    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      linuxConfiguration: osType == 'Linux' ? {
        disablePasswordAuthentication: false
      } : null
      windowsConfiguration: osType == 'Windows' ? {
        enableAutomaticUpdates: true
      } : null
    }

    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }

    licenseType: useHybridBenefit ? (osType == 'Windows' ? 'Windows_Server' : (osType == 'Linux' ? 'RHEL_BYOS' : null)) : null


    
  }
}
