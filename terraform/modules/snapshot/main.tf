resource "yandex_compute_snapshot_schedule" "vm_snapshot_schedule" {
  name        = var.schedule_name
  description = "Daily snapshot for ${var.instance_name}"

  schedule_policy {
    expression = "0 3 * * *" # Каждый день в 03:00 UTC
  }

  snapshot_count = 7 # Хранить последние 7 снимков

  disk_ids = var.disk_ids

  labels = {
    project = "diploma"
  }
}
