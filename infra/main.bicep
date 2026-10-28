targetScope = 'resourceGroup'

@description('Azure region for the deployed resources.')
param location string = resourceGroup().location

@description('Globally unique Azure AI Search service name.')
@minLength(2)
@maxLength(60)
param searchServiceName string = 'srch-${uniqueString(resourceGroup().id)}'

@description('Azure AI Search pricing tier.')
@allowed([
  'basic'
  'standard'
  'standard2'
  'standard3'
])
param searchSku string = 'standard2'

@description('Search replicas. Basic supports at most 3; Standard tiers support at most 12.')
@minValue(1)
@maxValue(12)
param searchReplicaCount int = 3

@description('Search partitions. Supported capacity depends on the tier; Standard S3 HighDensity supports at most 3.')
@allowed([
  1
  2
  3
  4
  6
  12
])
param searchPartitionCount int = 3

@description('HighDensity hosting is supported only with Standard S3 and up to 3 partitions.')
@allowed([
  'Default'
  'HighDensity'
])
param searchHostingMode string = 'Default'

@description('Semantic ranker billing plan; availability depends on the region and tier.')
@allowed([
  'disabled'
  'free'
  'standard'
])
param searchSemanticSearch string = 'standard'

@description('Public endpoint access. Disabled requires separately provisioned private networking.')
@allowed([
  'Enabled'
  'Disabled'
])
param searchPublicNetworkAccess string = 'Enabled'

@description('Tags applied to deployed resources.')
param tags object = {}

module search 'modules/search.bicep' = {
  name: 'search'
  params: {
    name: searchServiceName
    location: location
    sku: searchSku
    replicaCount: searchReplicaCount
    partitionCount: searchPartitionCount
    hostingMode: searchHostingMode
    semanticSearch: searchSemanticSearch
    publicNetworkAccess: searchPublicNetworkAccess
    tags: tags
  }
}

output searchServiceId string = search.outputs.resourceId
output searchServiceName string = search.outputs.serviceName
output searchEndpoint string = search.outputs.endpoint
output searchPrincipalId string = search.outputs.principalId