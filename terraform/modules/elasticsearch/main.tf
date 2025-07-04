terraform {
  }

resource "yandex_compute_instance" "elasticsearch" {
  name        = "elasticsearch-server"
  hostname    = "elasticsearch"
  platform_id = var.platform_id
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    nat                = false
    security_group_ids = [var.sg_id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
    user-data = <<-EOT
      #cloud-config
      packages:
        - elasticsearch
      runcmd:
        - systemctl enable elasticsearch --now
    EOT
  }
}
