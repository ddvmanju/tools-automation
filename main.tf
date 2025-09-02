module "vm" {
  for_each     = var.tools
  source       = "./vm-module"
  component    = each.key
  ssh_password = var.ssh_password
  ssh_username = var.ssh_username
  ports        = each.value["ports"]
  vm_size      = each.value["vm_size"]
  #role_definition_name = each.value["role_definition_name"]
}

variable "tools" {
  default = {

    vault = {
      vm_size = "Standard_B2s"
      ports = {
        vault = {
          name     = "vault"
          priority = 101
          port     = 8200
        }
      }
    }

    github-runner = {
      port = 443
      vm_size = "Standard_B2s"
      ports = {}
    }

    elasticsearch = {
      vm_size = "Standard_E2s_v3"
      ports = {
        elasticsearch = {
          name     = "elasticsearch"
          priority = 101
          port     = 9200
        }

        kibana = {
          name     = "kibana"
          priority = 102
          port     = 80
        }

        logstash = {
          name     = "logstash"
          priority = 103
          port     = 5044
        }

      }
    }

    #     jenkins = {
    #       port = 8080
    #     }
    #
    #     jenkins-agent = {
    #       port = 8080
    #     }
    #
    #     prometheus = {
    #       port = 9090
    #     }
    #
    #     prom-node = {
    #       port = 9100
    #     }

    #     sonarqube = {
    #       port = 9000
    #     }

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
  subscription_id = "a906d619-0839-4738-a908-227a8b69d458"
}