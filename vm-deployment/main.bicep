@description('The Azure region to deploy the VM')
param location string

@description('The name of the virtual machine')
param vmName string

@description('Attach to existing subnet?')
param addToExistingNetwork bool

@description('Existing Subnet ID')
param subnetId string

@description('OS disk size in GB')
@minValue(30)
@maxValue(4095)
param osDiskSizeGB int = 128

@description('OS disk type')
@allowed(['Standard_LRS', 'Premium_LRS', 'StandardSSD_LRS'])
param osDiskType string = 'Premium_LRS'

@description('VM image reference')
param imageReference object

@description('Admin username')
param adminUsername string = 'adminuser'

@secure()
@description('Admin password')
param adminPassword string

@description('VM size')
param vmSize string = 'Standard_DS1_v2'

// Network Interface - Always created
resource nic 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [{
      name: 'ipconfig1'
      properties: {
        // Only attach subnet if requested
        subnet: addToExistingNetwork ? { id: subnetId } : null
        privateIPAllocationMethod: 'Dynamic'
      }
    }]
  }
}

// Virtual Machine
resource vm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: { vmSize: vmSize }
    storageProfile: {
      imageReference: imageReference
      osDisk: {
        name: '${vmName}-osdisk'
        createOption: 'FromImage'
        diskSizeGB: osDiskSizeGB
        managedDisk: { storageAccountType: osDiskType }
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      linuxConfiguration: contains(imageReference.offer, 'Linux') ? {
        disablePasswordAuthentication: false
      } : null
      windowsConfiguration: contains(imageReference.offer, 'Windows') ? {
        enableAutomaticUpdates: true
      } : null
    }
    networkProfile: {
      networkInterfaces: [{ id: nic.id }]
    }
  }
}
