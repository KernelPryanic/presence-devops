module "storage" {
  source = "./modules/storage"

  project  = var.project
  zone     = var.disk_zone
  size     = var.disk_size
  snapshot = var.disk_snapshot
}

module "network" {
  source = "./modules/network"
}
