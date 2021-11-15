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

  disk_size     = var.gitlab_disk_size
  disk_snapshot = var.gitlab_disk_snapshot
}

module "infrastructure" {
  source = "./infrastructure"

  external_ip_address = module.persistent.external_ip_address.address
  gitlab_machine_type = var.gitlab_machine_type
  gitlab_home         = var.gitlab_home
}
