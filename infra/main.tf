terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.115.0"
    }
  }
}

provider "yandex" {
  token                    = file("keys/token")
  cloud_id                 = var.cloud
  folder_id                = var.folder
  zone                     = var.zonea
}

#Create network
resource "yandex_vpc_network" "sfnet" {
  name = "sfnet"
}

resource "yandex_vpc_subnet" "sfnetsub" {
  name = "sfnetsub"
  network_id = yandex_vpc_network.sfnet.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}

#Create instances

resource "yandex_compute_instance" "manager" {

  name = "manager"
  hostname = "manager"

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type = "network-ssd"
      size = 18
    }
  }

  allow_stopping_for_update = true

  resources {
    cores = 2
    memory = 2
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sfnetsub.id
    nat = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh_keys="${var.ssh_user.name}:${file(var.ssh_user.pub_key)}"
    user-data=local.user_config
  }
}

resource "yandex_compute_instance" "worker1" {

  name = "worker1"
  hostname = "worker1"

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type = "network-ssd"
      size = 18
    }
  }

  allow_stopping_for_update = true

  resources {
    cores = 2
    memory = 2
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sfnetsub.id
    nat = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh_keys="${var.ssh_user.name}:${file(var.ssh_user.pub_key)}"
    user-data=local.user_config
  }
}

resource "yandex_compute_instance" "worker2" {

  name = "worker2"
  hostname = "worker2"

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type = "network-ssd"
      size = 18
    }
  }

  allow_stopping_for_update = true

  resources {
    cores = 2
    memory = 2
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sfnetsub.id
    nat = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh_keys="${var.ssh_user.name}:${file(var.ssh_user.pub_key)}"
    user-data=local.user_config
  }
}

