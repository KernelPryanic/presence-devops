module "storage" {
  source = "./modules/storage"

  project = var.project
  zone    = var.zone
  size    = var.size
}

module "network" {
  source = "./modules/network"
}
