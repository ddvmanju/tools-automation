provider "vault" {
  address = "http://vault.azdevops.online:8200"
  token = var.token
}

terraform {
  backend "azurerm" {
    resource_group_name  = "project-setup1"
    storage_account_name = "d82tfstates"
    container_name       = "vault-tfstates"
    key                  = "terraform.tfstate"

  }
}

provider "azurerm" {
  features{}
  subscription_id = "00f9828e-4aad-42e5-ac92-a3c54883cbd3"
}
variable "token" {

}
