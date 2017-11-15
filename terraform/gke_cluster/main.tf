variable "cluster_initial_node_count" {}
variable "cluster_min_master_version" {}
variable "cluster_name" {}
variable "cluster_node_config_machine_type" {}
variable "cluster_node_version" {}
variable "cluster_zone" {}
variable "disk_name" {}
variable "disk_size" {}
variable "disk_type" {}
variable "disk_zone" {}

provider "google" {
  project = "refined-oven-169818"
  region  = "us-central1"
}

module "jenkins_disk" {
  name   = "${var.disk_name}"
  size   = "${var.disk_size}"
  type   = "${var.disk_type}"
  zone   = "${var.disk_zone}"
  source = "../modules/compute_disk"
}

module "container_cluster" {
  initial_node_count       = "${var.cluster_initial_node_count}"
  min_master_version       = "${var.cluster_min_master_version}"
  name                     = "${var.cluster_name}"
  node_config_machine_type = "${var.cluster_node_config_machine_type}"
  node_version             = "${var.cluster_node_version}"
  zone                     = "${var.cluster_zone}"
  source                   = "../modules/container_cluster"
}
