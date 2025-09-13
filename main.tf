module "vm" {
  for_each     = var.tools
  source       = "./vm-module"
  component    = each.key
  ssh_password = var.ssh_password
  ssh_username = var.ssh_username
  port         = each.value["port"]
  vm_size      = each.value["vm_size"]
  #role_definition_name = each.value["role_definition_name"]
}

variable "tools" {
  default = {

    vault = {
      vm_size = "Standard_B2s"
      port = {
          name     = "vault"
          priority = 101
          port     = 8200
        }
      }
    }
  }



variable "ssh_username" {}
variable "ssh_password" {}

terraform {
  backend "azurerm" {
    resource_group_name  = "project-setup1"
    storage_account_name = "d82tfstates"
    container_name       = "tools-tf-state"
    key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
  subscription_id = "00f9828e-4aad-42e5-ac92-a3c54883cbd3"
}