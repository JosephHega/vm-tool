@description('The Azure region to deploy the VM')
param location string

@description('The name of the resource group (only for reference, not created)')
param resourceGroupName string

@description('The name of the virtual machine')
param vmName string

@description('The VNet ID to attach the NIC to')
param vnetId string

@description('The Subnet ID within the VNet to attach the NIC to')
param subnetId string

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

// Automatically create a NIC and attach it to the specified VNet and Subnet
resource nic 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [{
      name: 'ipconfig1'
      properties: {
        subnet: { id: subnetId }
        privateIPAllocationMethod: 'Dynamic'
      }
    }]
  }
}

// VM Resource Definition with Dynamic Configuration
resource vm 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: vmName
  location: location
  zones: availabilityZoneMode == 'manual' ? availabilityZones : (availabilityZoneMode == 'auto' ? null : [])

  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    priority: useSpotInstances ? 'Spot' : 'Regular'

    securityProfile: enableTrustedLaunch ? {
      securityType: 'TrustedLaunch'
      uefiSettings: {
        secureBootEnabled: enableSecureBoot
        vTpmEnabled: enableVTPM
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
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }

    networkProfile: {
      networkInterfaces: [{
        id: nic.id
      }]
    }

    licenseType: useHybridBenefit ? 'RHEL_BYOS' : null
  }
}
