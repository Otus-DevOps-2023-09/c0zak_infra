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
 depends_on = [yandex_compute_instance.k8s-master, yandex_compute_instance.k8s-worker]

 provisioner "local-exec" {
    command = <<EOF
      echo '#!/bin/bash' > check_connection.sh && \
      echo '' >> check_connection.sh && \
      echo 'while true; do' >> check_connection.sh && \
      echo '    ssh -i ~/.ssh/appuser -o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=5 ubuntu@${yandex_compute_instance.k8s-master.network_interface.0.nat_ip_address} exit &>/dev/null' >> check_connection.sh && \
      echo '    if [ $? -eq 0 ]; then' >> check_connection.sh && \
      echo '        echo "Connected successfully"' >> check_connection.sh && \
      echo '        ssh -i ~/.ssh/appuser -o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=5 ubuntu@${yandex_compute_instance.k8s-master.network_interface.0.nat_ip_address} exit' >> check_connection.sh && \
      echo '        break' >> check_connection.sh && \
      echo '    else' >> check_connection.sh && \
      echo '        echo "Connection failed, retrying in 15 seconds"' >> check_connection.sh && \
      echo '        sleep 15' >> check_connection.sh && \
      echo '    fi' >> check_connection.sh && \
	    echo 'done' >> check_connection.sh && \
	    echo 'while true; do' >> check_connection.sh && \
	    echo '    ssh -i ~/.ssh/appuser -o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=5 ubuntu@${yandex_compute_instance.k8s-worker.network_interface.0.nat_ip_address} exit &>/dev/null' >> check_connection.sh && \
      echo '    if [ $? -eq 0 ]; then' >> check_connection.sh && \
      echo '        echo "Connected successfully"' >> check_connection.sh && \
      echo '        ssh -i ~/.ssh/appuser -o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=5 ubuntu@${yandex_compute_instance.k8s-worker.network_interface.0.nat_ip_address} exit' >> check_connection.sh && \
      echo '        break' >> check_connection.sh && \
      echo '    else' >> check_connection.sh && \
      echo '        echo "Connection failed, retrying in 15 seconds"' >> check_connection.sh && \
      echo '        sleep 15' >> check_connection.sh && \
      echo '    fi' >> check_connection.sh && \
	    echo 'done' >> check_connection.sh && \
      chmod +x check_connection.sh && \
      bash check_connection.sh && \
      echo '[master]' > inventory.ini && \
      echo 'master ansible_host=${yandex_compute_instance.k8s-master.network_interface.0.nat_ip_address} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/appuser' >> inventory.ini && \
	    echo '[worker]' >> inventory.ini && \
      echo 'worker ansible_host=${yandex_compute_instance.k8s-worker.network_interface.0.nat_ip_address} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/appuser' >> inventory.ini && \
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini ../ansible/playbooks/cluster_up.yml -v && \
	    sleep 10 && \
      rm -f inventory.ini && \
      rm -f check_connection.sh && \
      echo 'IP master: ${yandex_compute_instance.k8s-master.network_interface.0.nat_ip_address}'
      echo 'IP worker: ${yandex_compute_instance.k8s-worker.network_interface.0.nat_ip_address}'
    EOF
 }
}


resource "yandex_compute_disk" "boot-disk-master" {
  name     = "k8s-disk-master"
  type     = "network-ssd"
  zone     = "ru-central1-a"
  size     = "40"
  image_id = var.image_id
}

resource "yandex_compute_disk" "boot-disk-worker" {
  name     = "k8s-disk-worker"
  type     = "network-ssd"
  zone     = "ru-central1-a"
  size     = "40"
  image_id = var.image_id
}

resource "yandex_compute_instance" "k8s-master" {
  name = "k8s-master"
  labels = {
    tag  = "k8s-master"
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  resources {
    cores  = 4
    memory = 4
  }
  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-master.id
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
}

resource "yandex_compute_instance" "k8s-worker" {
  name = "k8s-worker"
  labels = {
    tag  = "k8s-worker"
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  resources {
    cores  = 4
    memory = 4
  }
  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-worker.id
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
}
