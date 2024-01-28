terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0"
    }
  }
  required_version = ">= 0.13"
}

resource "null_resource" "ansible_provisioner" {
 depends_on = [yandex_compute_instance.gitlab-vm]

 provisioner "local-exec" {
    command = <<EOF
      echo '#!/bin/bash' > check_connection.sh && \
      echo '' >> check_connection.sh && \
      echo 'while true; do' >> check_connection.sh && \
      echo '    ssh -i ~/.ssh/appuser -o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=5 ubuntu@${yandex_compute_instance.gitlab-vm.network_interface.0.nat_ip_address} exit &>/dev/null' >> check_connection.sh && \
      echo '    if [ $? -eq 0 ]; then' >> check_connection.sh && \
      echo '        echo "Connected successfully"' >> check_connection.sh && \
      echo '        ssh -i ~/.ssh/appuser -o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=5 ubuntu@${yandex_compute_instance.gitlab-vm.network_interface.0.nat_ip_address} exit' >> check_connection.sh && \
      echo '        break' >> check_connection.sh && \
      echo '    else' >> check_connection.sh && \
      echo '        echo "Connection failed, retrying in 15 seconds"' >> check_connection.sh && \
      echo '        sleep 15' >> check_connection.sh && \
      echo '    fi' >> check_connection.sh
      echo 'done' >> check_connection.sh && \
      chmod +x check_connection.sh && \
      bash check_connection.sh && \
      echo '[gitlab]' > inventory.ini && \
      echo 'gitlab_vm ansible_host=${yandex_compute_instance.gitlab-vm.network_interface.0.nat_ip_address} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/appuser' >> inventory.ini && \
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini ../ansible/playbooks/gitlab_install.yml -v && \
      rm -f inventory.ini && \
      rm -f check_connection.sh && \
      echo 'IP: ${yandex_compute_instance.gitlab-vm.network_interface.0.nat_ip_address}'
    EOF
 }
}


resource "yandex_compute_disk" "boot-disk" {
  name     = "gitlab-disk"
  type     = "network-ssd"
  zone     = "ru-central1-a"
  size     = "50"
  image_id = var.image_id
}

resource "yandex_compute_instance" "gitlab-vm" {
  name = "gitlab-vm"
  labels = {
    tag  = "gitlab-vm",
    type = var.instance_type
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  resources {
    cores  = 6
    memory = 6
  }
  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
}
