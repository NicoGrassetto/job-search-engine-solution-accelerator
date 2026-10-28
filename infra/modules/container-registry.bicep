targetScope = 'resourceGroup'

@description('Globally unique registry name: 5-50 alphanumeric characters.')
@minLength(5)
@maxLength(50)
param name string

@description('Azure region in which to create the container registry.')
param location string = resourceGroup().location

@description('Pricing tier for the container registry. Private endpoints require Premium.')
@allowed([
  'Basic'
  'Standard'
  'Premium'
])
param sku string = 'Standard'

@description('Public endpoint access. Disabled requires Premium and a separately provisioned private endpoint and DNS for image access.')
@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccess string = 'Enabled'

@description('Tags applied to the container registry.')
param tags object = {}

resource registry 'Microsoft.ContainerRegistry/registries@2025-11-01' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: false
    anonymousPullEnabled: false
    dataEndpointEnabled: false
    networkRuleBypassOptions: 'None'
    networkRuleBypassAllowedForTasks: false
    publicNetworkAccess: publicNetworkAccess
    roleAssignmentMode: 'LegacyRegistryPermissions'
    policies: {
      azureADAuthenticationAsArmPolicy: {
        status: 'enabled'
      }
      exportPolicy: {
        status: 'enabled'
      }
    }
  }
}

@description('Resource ID of the container registry.')
output resourceId string = registry.id

@description('Name of the container registry.')
output registryName string = registry.name

@description('Login server hostname used to tag, push, and pull container images.')
output loginServer string = registry.properties.loginServer