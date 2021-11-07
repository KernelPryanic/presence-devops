output "external_ip_address" {
  value = {
    address : google_compute_address.static.address
  }
}
