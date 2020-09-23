resource "local_file" "gcp_credential" {
    sensitive_content  = var.gcp_credential
    filename = "${path.module}/gcp_credential.json"
}

provider "google" {
  #credentials = file("${path.module}/gcp_credential.json")
  credentials = local_file.gcp_credential.filename
  project     = var.gcp_project
  region      = var.gcp_region
}

resource "google_compute_instance" "demo" {
  count        = var.instance_count
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
