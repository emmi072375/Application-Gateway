targetScope = 'subscription'

param myResourceGroup string = 'rg-ZellyTestProd02'

//Create Parameters for Application Gateway 

@description('Virtual Network name')
param virtualNetworkName string = 'Application-Vnet'

@description('Virtual Network address range')
param vnetAddressPrefix string = '10.0.0.0/16'

@description('Name of the subnet')
param subnetName string = 'ApplicationGatewaySubnet'

@description('Subnet address range')
param subnetPrefix string = '10.0.0.0/24'

@description('Application Gateway name')
param applicationGatewayName string = 'applicationGatewayV2'

@description('Minimum instance count for Application Gateway')
param minCapacity int = 2

@description('Maximum instance count for Application Gateway')
param maxCapacity int = 10

@description('Application Gateway Frontend port')
param frontendPort int = 80

@description('Application gateway Backend port')
param backendPort int = 80

@description('Back end pool ip addresses')
param backendIPAddresses array = [
  {
    IpAddress: '10.0.0.4'
  }
  {
    IpAddress: '10.0.0.5'
  }
]

@description('Cookie based affinity')
@allowed([
  'Enabled'
  'Disabled'
])
param cookieBasedAffinity string = 'Disabled'

@description('Location for all resources.')
param location string = 'swedencentral'




resource myRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: myResourceGroup
  location: location
}

module myAWTestprod 'aw.bicep' = {
  name: 'myAWTestDeployment'
  scope: myRG
  params: {
    virtualNetworkName: virtualNetworkName
    vnetAddressPrefix: vnetAddressPrefix
    subnetName: subnetName
    subnetPrefix: subnetPrefix
    applicationGatewayName: applicationGatewayName
    minCapacity: minCapacity
    maxCapacity: maxCapacity
    frontendPort: frontendPort
    backendPort: backendPort
    backendIPAddresses: backendIPAddresses
    cookieBasedAffinity: cookieBasedAffinity
    location: location
  }
}
