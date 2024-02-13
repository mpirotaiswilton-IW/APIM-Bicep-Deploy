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

## Testing the instance



## Removing the instance

The best way to remove the newly created API Management instance is to remove the resource group it belongs to. Using the Azure CLI run the following command, replacing \<name> with the resource group name you want deleted: 
```
az group delete -n <name>
```