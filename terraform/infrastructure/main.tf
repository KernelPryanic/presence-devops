module "gitlab" {
  source = "./modules/gitlab"

  gitlab_sa = var.gitlab_sa
  machine_type = var.machine_type
  external_ip_address = var.external_ip_address
  gitlab_home = var.gitlab_home
}
