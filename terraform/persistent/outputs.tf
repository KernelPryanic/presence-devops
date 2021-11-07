output "external_ip_address" {
  value = {
    address : module.network.external_ip_address.address
  }
}
