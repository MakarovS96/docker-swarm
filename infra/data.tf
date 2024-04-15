data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

locals {
  user_config = templatefile("files/cloud-config.tmpl", {
    username    = var.ssh_user.name
    ssh_key     = file(var.ssh_user.pub_key)
    user_groups = "sudoers"
  })
}

data "local_file" "swarm_token" {
  depends_on = [ null_resource.docker-swarm-worker-get-token ]
  filename = "keys/swarm_token"
}