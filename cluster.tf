resource "google_compute_disk" "wordpress-disk" {
  name = "wordpress-disk"
  zone = "${var.gcloud-zone}"
  size = 200
}

resource "google_compute_disk" "mysql-disk" {
  name = "mysql-disk"
  zone = "${var.gcloud-zone}"
  size = 200
}

resource "google_container_cluster" "cluster" {
  depends_on         = ["google_compute_disk.wordpress-disk", "google_compute_disk.mysql-disk"]
  name               = "${var.cluster-name}"
  zone               = "${var.gcloud-zone}"
  initial_node_count = "${var.cluster-size}"

  master_auth {
    username = "${var.username}"
    password = "${var.password}"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    machine_type = "${var.machine-type}"
  }

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.cluster-name} --zone ${var.gcloud-zone} --project ${var.gcloud-project}"
  }

  provisioner "local-exec" {
    command = "kubectl cluster-info"
  }

  provisioner "local-exec" {
    command = "kubectl create secret generic mysql --from-literal=password=${var.password}"
  }

  provisioner "local-exec" {
    command = "kubectl create -f ."
  }
}
