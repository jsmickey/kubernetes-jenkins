variable "name" {}
variable "size" {}
variable "type" {}
variable "zone" {}

resource "google_compute_disk" "disk" {
  name = "${var.name}"
  size = "${var.size}"
  type = "${var.type}"
  zone = "${var.zone}"
}
