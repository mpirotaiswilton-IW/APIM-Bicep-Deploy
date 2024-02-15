param apiManagementServiceName string

param apiPathName string = 'api'


resource api 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
  name: '${apiManagementServiceName}/${apiPathName}'
  properties:{
    format:'swagger-json'
    value: loadTextContent('../resources/api-spec.json')
    path: 'api'
  }
}

resource product 'Microsoft.ApiManagement/service/products@2022-08-01' = {
  name: '${apiManagementServiceName}/${apiPathName}'
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
    value: loadTextContent('../resources/policy.xml')
  }
}

resource exampleApiLink 'Microsoft.ApiManagement/service/products/apis@2022-08-01' = {
  parent: product
  name: apiPathName
  dependsOn:[
    api
  ]
}
