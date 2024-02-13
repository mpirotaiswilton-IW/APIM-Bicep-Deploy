param apiManagementServiceName string = 'apiservice${uniqueString(resourceGroup().id)}'
param publisherEmail string
param publisherName string

param sku string = 'Developer'
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

resource exampleApi 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
  parent: apiManagementService
  name: 'exampleApi'
  properties:{
    format:'swagger-json'
    value: loadTextContent('./resources/api-spec.json')
    path: 'exampleApi'
  }
}

resource product 'Microsoft.ApiManagement/service/products@2022-08-01' = {
  parent: apiManagementService
  name: 'product'
  properties:{
    displayName: 'Test Product'
    description: 'Test Product for APIM test'
    subscriptionRequired: true
    approvalRequired: false
    subscriptionsLimit: 1
    state: 'published'
  }
}

resource policy 'Microsoft.ApiManagement/service/products/policies@2022-08-01' = {
  parent: product
  name: 'policy'
  properties: {
    format: 'xml'
    value: loadTextContent('./resources/policy.xml')
  }
}

resource exampleApiLink 'Microsoft.ApiManagement/service/products/apis@2022-08-01' = {
  parent: product
  name: 'exampleApi'
  dependsOn:[
    exampleApi
  ]

}
