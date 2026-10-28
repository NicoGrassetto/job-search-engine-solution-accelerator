targetScope = 'resourceGroup'

@description('Globally unique service name: 2-60 lowercase letters, digits, or single hyphens; start and end with a letter or digit.')
@minLength(2)
@maxLength(60)
param name string

@description('Azure region in which to create the search service.')
param location string = resourceGroup().location

@description('Pricing tier for the search service.')
@allowed([
  'basic'
  'standard'
  'standard2'
  'standard3'
])
param sku string = 'standard2'

@description('Number of replicas. Basic supports at most 3; Standard tiers support at most 12.')
@minValue(1)
@maxValue(12)
param replicaCount int = 3

@description('Number of partitions. Supported capacity depends on the tier; Standard S3 HighDensity supports at most 3.')
@allowed([
  1
  2
  3
  4
  6
  12
])
param partitionCount int = 3

@description('HighDensity is supported only with Standard S3 and up to 3 partitions.')
@allowed([
  'Default'
  'HighDensity'
])
param hostingMode string = 'Default'

@description('Semantic ranker billing plan. Availability depends on the selected region and tier.')
@allowed([
  'disabled'
  'free'
  'standard'
])
param semanticSearch string = 'standard'

@description('Public endpoint access. Disabled requires a separately provisioned private endpoint and DNS.')
@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccess string = 'Enabled'

@description('Tags applied to the search service.')
param tags object = {}

resource searchService 'Microsoft.Search/searchServices@2025-05-01' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: sku
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    hostingMode: hostingMode
    replicaCount: replicaCount
    partitionCount: partitionCount
    semanticSearch: semanticSearch
    publicNetworkAccess: publicNetworkAccess
    disableLocalAuth: true
  }
}

@description('Resource ID of the search service.')
output resourceId string = searchService.id

@description('Name of the search service.')
output serviceName string = searchService.name

@description('Data-plane endpoint of the search service.')
output endpoint string = searchService.properties.endpoint

@description('Principal ID of the search service identity, for outbound access to other Azure resources.')
output principalId string = searchService.identity.principalId