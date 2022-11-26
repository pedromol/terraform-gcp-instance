resource "google_compute_firewall" "this" {
  name    = "${var.prefix_display_name}-firewall"
  network = google_compute_network.this.name

  allow {
    protocol = "tcp"
    ports    = var.ingress_allowed_tcp
  }

  allow {
    protocol = "udp"
    ports    = var.ingress_allowed_udp
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_network" "this" {
  name                    = "${var.prefix_display_name}-network"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "this" {
  name          = "${var.prefix_display_name}-subnet"
  ip_cidr_range = var.network-subnet-cidr
  network       = google_compute_network.this.name
  region        = var.gcp_region
}

resource "google_compute_disk" "this" {
  name = "${var.prefix_display_name}-disk"
  type = "pd-standard"
  zone = var.gcp_zone
  size = 30
}

resource "google_compute_instance" "this" {
  name                      = "${var.prefix_display_name}0"
  machine_type              = var.vm_instance_type
  zone                      = var.gcp_zone
  can_ip_forward            = "true"
  allow_stopping_for_update = "true"

  boot_disk {
    initialize_params {
      image = var.os_image
    }
  }

  attached_disk {
    source      = google_compute_disk.this.self_link
    device_name = google_compute_disk.this.name
  }

  metadata = {
    ssh-keys = "${var.user}:${file(var.ssh_public_key_path)}"
  }

  network_interface {
    network    = google_compute_network.this.name
    subnetwork = google_compute_subnetwork.this.name
    access_config {
    }
  }

  scheduling {
    automatic_restart = true
  }
}

resource "cloudflare_record" "instance_name" {
  zone_id = var.cloudflare_zone_id
  name    = var.cloudflare_instance_name
  value   = google_compute_instance.this.network_interface.0.access_config.0.nat_ip
  type    = "A"
  proxied = false
}