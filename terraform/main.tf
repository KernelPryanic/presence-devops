terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "presence-game-devops"
    prefix = "terraform"
  }
}

module "persistent" {
  source = "./persistent"
}

module "infrastructure" {
  source = "./infrastructure"

  machine_type = var.machine_type
  external_ip_address = module.persistent.external_ip_address.address
  gitlab_home = var.gitlab_home
}
