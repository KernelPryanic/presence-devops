project_id = "presence-game"
zone       = "europe-west4-a"
builder_sa = "packer@presence-game.iam.gserviceaccount.com"

src_image_family = "ubuntu-2004-lts"
dst_image_family = "gitlab"
image_name       = "gitlab"

gitlab_version        = "14.4.1-ee.0"
gitlab_runner_version = "alpine-v14.4.0"
gitlab_home           = "/srv/gitlab"
