output "manager_ip" {
  value = yandex_compute_instance.manager.network_interface[0].nat_ip_address
  description = "IP address of sockshop webpage"
}