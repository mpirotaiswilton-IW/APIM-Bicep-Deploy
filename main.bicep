param apimServiceNamePrefix string = 'apiservice'

param apiManagementServiceName string = '${apimServiceNamePrefix}${uniqueString(resourceGroup().id)}'

param publisherEmail string
param publisherName string
@allowed([
  'Basic'
  'BasicV2'
  'Consumption'
  'Developer'
  'Isolated'
  'Premium'
  'Standard'
  'StandardV2' 
])
param apimSku string = 'Developer'
@allowed([
  0
  1
  2
])
param apimSkuCount int = 1

param apiPathName string = 'api'

param location string = resourceGroup().location

module apim './modules/apim.bicep' = {
  name: 'apim'
  params: {
    apiManagementServiceName: apiManagementServiceName
    location: location
    publisherEmail: publisherEmail
    publisherName: publisherName
    sku: apimSku
    skuCount: apimSkuCount
  }
}

module apimResources './modules/apim-resources.bicep' = {
  name: 'apim-resources'
  params: {
    apiManagementServiceName: apiManagementServiceName
    apiPathName: apiPathName
  }
  dependsOn: [
    apim
  ]
}
