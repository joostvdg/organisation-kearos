terraform {
  required_version = ">= 0.11.8"
}

provider "google" {
  version     = ">= 1.19.0"
  credentials = "${file("${var.credentials}")}"
  project     = "${var.gcp_project}"
}

data "google_container_engine_versions" "europe-west4" {
  location        = "${var.gcp_location}"
  version_prefix  = "1.12."
}

resource "google_container_node_pool" "joostvdg-cbc-node-pool-builds" {
  name       = "builds-pool"
  location   = "${var.gcp_location}"
  cluster    = "${google_container_cluster.joostvdg-cbc-cluster.name}"
  node_count = "${var.min_node_count_builds}"

  node_config {
    preemptible  = "${var.node_preemptible}"
    machine_type = "${var.node_machine_type_builds}"
    disk_size_gb = "${var.node_disk_size}"

    labels {
      "cbc.type" = "builds"
    }

    # TODO: make sure CJOC and MM's cannot be scheduled here
    # taint = {
    #   effect = "NO_SCHEDULE"
    #   key    = "fs-node-use"
    #   value  = "my-value"
    # }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "${var.node_devstorage_role}",
      "https://www.googleapis.com/auth/service.management",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  autoscaling {
    min_node_count = "${var.min_node_count_builds}"
    max_node_count = "${var.max_node_count_builds}"
  }

  management {
    auto_repair  = "${var.auto_repair}"
    auto_upgrade = "${var.auto_upgrade}"
  }

}

resource "google_container_node_pool" "joostvdg-cbc-node-pool-masters" {
  name       = "masters-pool"
  location   = "${var.gcp_location}"
  cluster    = "${google_container_cluster.joostvdg-cbc-cluster.name}"
  node_count = "${var.min_node_count}"

  node_config {
    preemptible  = "${var.node_preemptible}"
    machine_type = "${var.node_machine_type}"
    disk_size_gb = "${var.node_disk_size}"

    labels {
      "cbc.type" = "masters"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "${var.node_devstorage_role}",
      "https://www.googleapis.com/auth/service.management",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  autoscaling {
    min_node_count = "${var.min_node_count}"
    max_node_count = "${var.max_node_count}"
  }

  management {
    auto_repair  = "${var.auto_repair}"
    auto_upgrade = "${var.auto_upgrade}"
  }

}

resource "google_container_cluster" "joostvdg-cbc-cluster" {
  name                     = "${var.cluster_name}"
  description              = "joostvdg-cbc"
  location                 = "${var.gcp_location}"
  enable_kubernetes_alpha  = "${var.enable_kubernetes_alpha}"
  enable_legacy_abac       = "${var.enable_legacy_abac}"
  initial_node_count       = "${var.min_node_count}"
  remove_default_node_pool = "true"
  logging_service          = "${var.logging_service}"
  monitoring_service       = "${var.monitoring_service}"
  node_version             = "${data.google_container_engine_versions.europe-west4.latest_node_version}"
  min_master_version       = "${data.google_container_engine_versions.europe-west4.latest_node_version}"

  resource_labels {
    created-by = "${var.created_by}"
    created-timestamp = "${var.created_timestamp}"
    created-with = "terraform"
  }

  lifecycle {
    ignore_changes = ["node_pool"]
  }
}
