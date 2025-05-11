using 'main.bicep'


param resourceGroupName = 'linuxVM-rg'

// 'germanywestcentral'
param location = 'germanywestcentral'
param vmName = 'linux-vm-new-test'

// Options: 'Windows' or 'Linux'
param osType = 'Linux'

// Virtual Machine Size (SKU)
// - 'Standard_B2s' (Low-cost, burstable VM)
// - 'Standard_DS1_v2' (General-purpose, 1 vCPU, 3.5 GB RAM)
// - 'Standard_DS4_v2' (General-purpose, 8 vCPU, 28 GB RAM)
// - 'Standard_E4s_v3' (Memory-optimized, 4 vCPU, 32 GB RAM)
param vmSize = 'Standard_DS4_v2'

// Networking Configuration: Attach VM to an Existing Network
// Options: true (attach to existing network), false (create new network)
param addToExistingNetwork = true

// Subnet ID 
param subnetId = '/subscriptions/fb4e727e-f4b0-42b0-8950-8a4961a2bce9/resourceGroups/prod-rg/providers/Microsoft.Network/virtualNetworks/vnet-germanywestcentral/subnets/snet-germanywestcentral-1'

// Options: true (create a public IP), false (no public IP)
param createPublicIP = false

// Recommended Values: 30 (minimum), 64, 128, 256, 512
param osDiskSizeGB = 127

// OS Disk Type (Managed Disk Type)
// Options:
// - 'Standard_LRS' (Standard HDD, low-cost, slow)
// - 'StandardSSD_LRS' (Standard SSD, balanced performance)
// - 'Premium_LRS' (Premium SSD, high performance)
// - 'Premium_ZRS' (Premium SSD with Zone Redundancy)
param osDiskType = 'StandardSSD_LRS'


param imageReference = {
  publisher: 'RedHat'  // OS Publisher
  offer: 'RHEL'        // OS Offer (Red Hat Enterprise Linux)
  sku: '8-lvm-gen2'    // SKU (Version and Type)
  version: 'latest'    // Always use the latest version
}

// Availability Zone Configuration
// Options:
// - 'none' (No Availability Zones)
// - 'manual' (Manually specify zones in 'availabilityZones')
// - 'auto' (Azure auto-distributes across zones)
param availabilityZoneMode = 'auto' 

// Specify Zones if 'manual' is selected for 'availabilityZoneMode'
// Example: ['1', '2', '3']
param availabilityZones = []

// Options: true (enable hybrid benefit), false (disable)
param useHybridBenefit = false

// Options: true (use Spot Instances), false (use regular VM)
param useSpotInstances = false


param adminUsername = 'testadmin'
param adminPassword = 'testpassword123!'

