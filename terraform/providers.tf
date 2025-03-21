terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0.0"

  backend "azurerm" {
    resource_group_name   = "rg-dhina-terraform-state"
    storage_account_name  = "tfstatedhina"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
    access_key            = "lcuVvnPJT0lYrQciVsa1xO+Q3lfkFbAvtyH4L8qeUO+VNPtmXvS6gpkbQ+bvaRmwKIZTJmeemuJE+AStoXuDTw=="
  }
}

provider "azurerm" {
  features {}

  # Your Azure Subscription ID
  subscription_id = "38bd44d5-d91c-4f34-8f1e-c946d6697ae4"
}