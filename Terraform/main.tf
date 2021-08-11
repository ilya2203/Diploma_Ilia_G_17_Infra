terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.56"   
    }
  }
backend "azurerm" {
    resource_group_name  = "__azureRG__"
    storage_account_name = "__azureStorageAccount__"
      cointainer_name    = "terraform"
      key                = "terraform.tfstate"
    access_key = "__storagekey__"
    }
}

provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "gozhin" {
  name                     = "gozhin02"
  resource_group_name      = "__azureRG__"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    owner = "ilia_gozhin@epam.com"
  }
}