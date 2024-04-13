resource "null_resource" "docker-swarm-manager-init" {
    depends_on = [ yandex_compute_instance.manager ]

    connection {
        type = "ssh"
        host = yandex_compute_instance.manager.network_interface[0].nat_ip_address
        user = var.ssh_user.name
        private_key = file(var.ssh_user.private_key)
    }

    provisioner "file" {
      source = "../docker-compose.yml"
      destination = "~/docker-compose.yml"
    }

    provisioner "local-exec" {
        command = "ansible-playbook -u sennin -i '${yandex_compute_instance.manager.network_interface[0].nat_ip_address},' --private-key ${var.ssh_user.private_key} ansible/docker-install-playbook.yml"
    }

    provisioner "local-exec" {
        command = "ansible-playbook -u sennin -i '${yandex_compute_instance.manager.network_interface[0].nat_ip_address},' --private-key ${var.ssh_user.private_key} ansible/docker-swarm-manager-playbook.yml"
    }
}

resource "null_resource" "docker-swarm-worker-get-token" {
    depends_on = [ yandex_compute_instance.manager, null_resource.docker-swarm-manager ]
    connection {
        type = "ssh"
        host = yandex_compute_instance.manager.network_interface[0].nat_ip_address
        user = var.ssh_user.name
        private_key = file(var.ssh_user.private_key)
    }

    provisioner "local-exec" {
        command = "echo $(ssh -i ${var.ssh_user.private_key} -o StrictHostKeyChecking=no ${var.ssh_user.name}@${yandex_compute_instance.manager.network_interface[0].nat_ip_address} docker swarm join-token -q worker) > keys/swarm_token"
    }
}