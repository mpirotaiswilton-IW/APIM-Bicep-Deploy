param apiManagementServiceName string = 'apiservice${uniqueString(resourceGroup().id)}'
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
param sku string = 'Developer'
@allowed([
  0
  1
  2
])
param skuCount int = 1

param location string = resourceGroup().location

resource apiManagementService 'Microsoft.ApiManagement/service@2022-08-01' = {
  name: apiManagementServiceName
  location: location
  sku: {
    name: sku
    capacity: skuCount
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}
