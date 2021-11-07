variable "gitlab_sa" {
  default = {
    "account_id" : "gitlab-sa",
    "display_name" : "GitLab Service Account"
  }
}

variable "external_ip_address" {}

variable "gitlab_home" {
  default = "/srv/gitlab"
}

variable "machine_type" {
  default = "n1-standard-2"
}
