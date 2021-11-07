resource "google_compute_address" "static" {
  name = "presence"
}

resource "google_compute_firewall" "web" {
 name    = "web-firewall"
 network = "default"

 allow {
   protocol = "icmp"
 }

 allow {
   protocol = "tcp"
   ports    = ["80", "443"]
 }

 source_ranges = ["0.0.0.0/0"]
 target_tags = ["web"]
}

# resource "google_dns_managed_zone" "main" {
#   name     = "main-zone"
#   dns_name = "presence.icu."
# }

# resource "google_dns_record_set" "gitlab" {
#   name = "gitlab.${google_dns_managed_zone.main.dns_name}"
#   type = "A"
#   ttl  = 300

#   managed_zone = google_dns_managed_zone.main.name

#   rrdatas = [google_compute_address.static.address]
# }
