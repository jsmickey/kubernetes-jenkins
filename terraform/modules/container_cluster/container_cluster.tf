variable "initial_node_count" {}
variable "min_master_version" {}
variable "name" {}
variable "node_config_machine_type" {}
variable "node_version" {}
variable "zone" {}

resource "google_container_cluster" "cluster" {
  initial_node_count = "${var.initial_node_count}"
  min_master_version = "${var.min_master_version}"
  name               = "${var.name}"

  node_config {
    machine_type = "${var.node_config_machine_type}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_version = "${var.node_version}"
  zone         = "${var.zone}"
}
