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

param apiPathName string = 'api'

param location string = resourceGroup().location

// resource apiManagementService 'Microsoft.ApiManagement/service@2022-08-01' = {
//   name: apiManagementServiceName
//   location: location
//   sku: {
//     name: sku
//     capacity: skuCount
//   }
//   properties: {
//     publisherEmail: publisherEmail
//     publisherName: publisherName
//   }
// }

module apim './modules/apim.bicep' = {
  name: 'apim'
  params: {
    apiManagementServiceName: apiManagementServiceName
    location: location
    publisherEmail: publisherEmail
    publisherName: publisherName
    sku: apimSku
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
