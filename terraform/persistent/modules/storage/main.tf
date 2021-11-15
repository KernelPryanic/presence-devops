resource "google_compute_disk" "gitlab_data" {
  name                      = "gitlab-data"
  type                      = "pd-standard"
  project                   = var.project
  zone                      = var.zone
  size                      = var.size
  snapshot                  = var.snapshot
  physical_block_size_bytes = 4096

  lifecycle {
    prevent_destroy = true
  }
}
