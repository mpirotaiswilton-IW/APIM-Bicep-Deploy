# APIM-Bicep-Deploy
This Github repo contains a bicep file to deploy a developer instance of an Azure API Management service.

## Pre-requisites and Setup

1. Before starting make sure you:

* Have an Azure [free account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F) with an Azure subscription
* Have access to the Azure CLI. You can install it locally using the guide here: <https://learn.microsoft.com/en-us/cli/azure/install-azure-cli> . Make sure to sign-in by using the following commands: 
    ```command line
    # Sign-in to Azure with web portal sign-in page
    az login

    # Verify which account is currently signed in
    az account show
    ```

2. Clone this repository or download the .zip file from GitHub (then extract the downloaded zip file)

## Deployment

1. Using the Command Line Interface of your choosing, change directory to the downloaded/cloned repository

2. To deploy the API Management instance
    1. Make sure you have a resource group running in you Azure subscription specifically for the API Management instance. If you don't, run the following command, replacing \<name> and \<location> with the name of the new resource group and it's deployment location:
        ```
        az group create -n <name> -l <location>
        ```
    1. To deploy the Azure API Management instance, run the following command, replacing **\<publisher-email>** and **\<publisher-name>** with the email address to receive notification and the name of the API publishers organization: 
        ```
        az deployment group create -g exampleRG -f main.bicep -p publisherEmail=<publisher-email> publisherName=<publisher-name>
        ```
        Deploying this instance will take a long time

3. Once you receive a new email at your designated **\<publisher-email>**, the API Manager instance will have finished deploying and will be ready to use.

You can verify the instance has deployed by running the following command, replacing **\<name>** with the resource group name you want deleted: 

```
az resource list --resource-group <name>
```

## Verifying and Testing the instance's properties

As the API Management instance has been deployed, the bicep file also specifies an API and a product (along with a policy and an api link) to be added to the instance. These are specified in the [apim-resources.bicep]() file.

To verify the API and product have been added to the API Management correctly, we must first find the API Management instance on the Azure Portal website:
1. Using a web browser, go to <https://portal.azure.com/>. Sign-in with the same credentials as in your Azure CLI.
2. On the home page under the `Navigate` section, click on `Resource groups`
3. Click on the Resource group where you deployed your API Management instance
4. In the `Overview` section, you should see a resource of type API Management service: This is our newly deployed instance. Click on it.
5. You 

#### Verifying the product

Starting from the API Managment instance page on Azure Portal:

1. On the left-hand side of your browser window, click on `Products` then, in the list of Products, click on the product named `Test Product`. You should now see an overview of the product created by the bicep file
2. On the left-hand side of your browser window, click on `APIs`. You should see one item in a list with the name `exampleApi` and display name `Demo Conference API`.
3. On the left-hand side of your browser window, click on `Policies`. You should see, in a window with the titled `Inbound processing`, 2 specified policies: 
    * `rate-limit`
    * `quota`

#### Verifying and testing our API

Starting from the API Managment instance page on Azure Portal:

1. On the left-hand side of your browser window, click on `APIs`. From here there should be 2 APIs listed under `All API`: 
    * `Demo Conference API`
    * `Echo API`

    The former is the API that was added by the bicep file. (This API was provided by Microsoft for use in this [tutorial](https://learn.microsoft.com/en-us/azure/api-management/import-and-publish). Its specification file is also available here: <https://conferenceapi.azurewebsites.net/?format=json>)

2. Click on the `Demo Conference API`
3. Click on `Test` tab. You will see a list of all API endpoints available to test. Select the `GetSpeakers` endpoint and click on `Send`
4. In the `HTTP response`, you should see you received 200 OK response code and a response body containing a list of names.

## Removing the instance

The best way to remove the newly created API Management instance is to remove the resource group it belongs to. Using the Azure CLI run the following command, replacing \<name> with the resource group name you want deleted: 
```
az group delete -n <name>
```