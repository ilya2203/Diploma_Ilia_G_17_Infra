terraform {
  required_providers {
    azurerm   = {
      source  = "hashicorp/azurerm"
      version = ">=2.56"   
    }
  }
  backend "azurerm" {
      resource_group_name  = "__azureRG__"
      storage_account_name = "__azureStorageAccount__"
        cointainer_name    = "terraform"
        key                = "terraform.tfstate"
      access_key           = "__storagekey__"
      }
}

provider "azurerm" {
  features {}
}

resource "azurerm_kubernetes_cluster" "gozhin" {
  name                = "gozhin-k8s-01"
  kubernetes_version  = "1.20.7"
  resource_group_name = "__azureRG__"
  location            = "__azureLocation__"
  dns_prefix          = "gozhin-k8s-01-dns"
    tags              = {
    owner             = "ilia_gozhin@epam.com"
  }

  default_node_pool {
    name                = "system"
    node_count          = 1
    vm_size             = "standard_b2s"
    type                = "VirtualMachineScaleSets"
    availability_zones  = [1, 2, 3]
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet"
  }
}

resource "azurerm_postgresql_flexible_server" "gozhin" {
  name                   = "gozhin-psqlflexibleserver-01"
  resource_group_name    = "__azureRG__"
  location               = "__azureLocation__"
  version                = "12"
  administrator_login    = "psqladminun"
  administrator_password = "H@Sh1CoR3!"
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
  tags                   = {
    owner                = "ilia_gozhin@epam.com"
  }
}

resource "azurerm_container_registry" "gozhin" {
  name                = "gozhinContainerRegistry01"
  resource_group_name = "__azureRG__"
  location            = "__azureLocation__"
  sku                 = "Basic"
  admin_enabled       = false
  tags                = {
    owner             = "ilia_gozhin@epam.com"
  }
}