variable "project_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "builder_sa" {
  type = string
}

variable "src_image_family" {
  type = string
}

variable "dst_image_family" {
  type = string
}

variable "image_name" {
  type = string
}

variable "gitlab_version" {
  type = string
}

variable "gitlab_runner_version" {
  type = string
}

variable "gitlab_home" {
  type = string
}

source "googlecompute" "gitlab" {
  project_id = var.project_id
  zone       = var.zone

  ssh_username                = "root"
  tags                        = ["packer"]
  impersonate_service_account = var.builder_sa
  disk_size                   = 20
  disk_type                   = "pd-ssd"

  source_image_family = var.src_image_family
  image_family        = var.dst_image_family
  image_name          = "${var.image_name}-{{timestamp}}"
  image_description   = "Created with Packer from CloudBuild"
}

build {
  sources = ["sources.googlecompute.gitlab"]

  provisioner "shell" {
    script = "scripts/install-docker.sh"
  }

  provisioner "shell" {
    inline = [
      "apt-get install net-tools"
    ]
  }

  provisioner "shell" {
    inline = [
      "docker pull gitlab/gitlab-ee:${var.gitlab_version}",
      "docker pull gitlab/gitlab-runner:${var.gitlab_runner_version}",
      "docker swarm init",
      "echo '#!/bin/bash\n\nGITLAB_HOME=${var.gitlab_home} GITLAB_VERSION=${var.gitlab_version} GITLAB_RUNNER_VERSION=${var.gitlab_runner_version} docker stack deploy -c /opt/gitlab/docker-compose.yml gitlab' > /etc/rc.local",
      "chmod +x /etc/rc.local",
      "systemctl enable rc-local.service",
      "mkdir -p /opt/gitlab"
    ]
  }

  provisioner "file" {
    source      = "swarm/docker-compose.yml"
    destination = "/opt/gitlab/docker-compose.yml"
  }

  provisioner "file" {
    source      = "swarm/gitlab.rb"
    destination = "/opt/gitlab/gitlab.rb"
  }

  provisioner "file" {
    source      = "swarm/root_password.txt"
    destination = "/opt/gitlab/root_password.txt"
  }

  provisioner "file" {
    source      = "swarm/runner_token.txt"
    destination = "/opt/gitlab/runner_token.txt"
  }

  provisioner "file" {
    source      = "swarm/config.toml"
    destination = "/opt/gitlab/config.toml"
  }
}
