variable "project" {
  default = "presence-game"
}

variable "region" {
  default = "europe-west4"
}

variable "gitlab_machine_type" {
  default = "n1-standard-2"
}

variable "gitlab_disk_size" {
  default = 300
}

variable "gitlab_disk_snapshot" {
  default = null
}

variable "gitlab_home" {
  default = "/srv/gitlab"
}
