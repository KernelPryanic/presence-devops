resource "google_service_account" "gitlab_sa" {
  account_id   = var.gitlab_sa.account_id
  display_name = var.gitlab_sa.display_name
}

resource "google_compute_instance" "gitlab" {
  name         = "gitlab"
  machine_type = var.machine_type
  zone         = "europe-west4-c"

  tags = ["cicd", "gitlab", "web"]

  boot_disk {
    initialize_params {
      image = "gitlab"
    }
  }

  attached_disk {
    source = "gitlab-data"
    device_name = "gitlab"
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = var.external_ip_address
    }
  }

  metadata_startup_script = <<-EOT
    if [[ $(blkid /dev/disk/by-id/google-gitlab) == "" ]]
    then
      mkfs.ext4 /dev/disk/by-id/google-gitlab
    fi
    umount ${var.gitlab_home}
    mount -o discard,defaults /dev/disk/by-id/google-gitlab ${var.gitlab_home}
    mkdir -p ${var.gitlab_home}/{data,logs,config}
  EOT

  service_account {
    email  = google_service_account.gitlab_sa.email
    scopes = ["cloud-platform"]
  }
}
