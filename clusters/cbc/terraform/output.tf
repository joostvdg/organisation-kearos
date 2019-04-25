output "cluster_endpoint" {
  value = "${google_container_cluster.joostvdg-cbc-cluster.endpoint}"
}

output "cluster_master_version" {
  value = "${google_container_cluster.joostvdg-cbc-cluster.master_version}"
}
