created_by = "joostvdg"
created_timestamp = "20190422214719"
cluster_name = "joostvdg-cbc"
organisation = "kearos"
provider = "gke"
gcp_location = "europe-west4"
gcp_project = "ps-dev-201405"
min_node_count = "1"
max_node_count = "2"
node_machine_type = "n1-standard-2"
min_node_count_builds = "1"
max_node_count_builds = "3"
node_machine_type_builds = "n1-standard-1"
node_preemptible = "false"
node_disk_size = "100"
auto_repair = "true"
auto_upgrade = "true"
enable_kubernetes_alpha = "false"
enable_legacy_abac = "false"
logging_service = "logging.googleapis.com"
monitoring_service = "monitoring.googleapis.com"
node_devstorage_role = "https://www.googleapis.com/auth/devstorage.read_only"
credentials = "jx-kearos.key.json"
