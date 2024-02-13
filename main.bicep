param apiManagementServiceName string = 'apiservice${uniqueString(resourceGroup().id)}'
param publisherEmail string
param publisherName string

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
  }
}

module apimResources './modules/apim-resources.bicep' = {
  name: 'apim-resources'
  params: {
    apiManagementServiceName: apiManagementServiceName
  }
}
