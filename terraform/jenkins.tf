# Compute instance group for masters

resource "yandex_compute_instance_group" "jenkins-masters" {
  name               = "jenkins-masters"
  service_account_id = "ajepbkjqj5mid7ge8ia6"
  depends_on = [
    yandex_vpc_network.netology-net,
    yandex_vpc_subnet.public,
  ]
  
  # Шаблон экземпляра, к которому принадлежит группа экземпляров.
  instance_template {

    # Имя виртуальных машин, создаваемых Instance Groups
    name = "jenkins-master-{instance.index}"

    # Ресурсы, которые будут выделены для создания виртуальных машин в Instance Groups
    resources {
      cores  = 2
      memory = 2
      core_fraction = 20 # Базовый уровень производительности vCPU. https://cloud.yandex.ru/docs/compute/concepts/performance-levels
    }

    # Загрузочный диск в виртуальных машинах в Instance Groups
    boot_disk {
      initialize_params {
        image_id = "fd8jvcoeij6u9se84dt5" # centos 7
        size     = 20
        type     = "network-ssd"
      }
    }

    network_interface {
      network_id = yandex_vpc_network.netology-net.id
      subnet_ids = [
        yandex_vpc_subnet.public.id,
      ]
      # Флаг nat true указывает что виртуалкам будет предоставлен публичный IP адрес.
      nat = true
    }

    metadata = {
      ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
    }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    zones = [
      "ru-central1-a",
    ]
  }

  deploy_policy {
    max_unavailable = 1
    max_creating    = 1
    max_expansion   = 1
    max_deleting    = 1
  }
}

# Compute instance group for workers

resource "yandex_compute_instance_group" "jenkins-agents" {
  name               = "jenkins-agents"
  service_account_id = "ajepbkjqj5mid7ge8ia6"
  depends_on = [
    yandex_vpc_network.netology-net,
    yandex_vpc_subnet.public,
  ]

  instance_template {

    name = "jenkins-agent-{instance.index}"

    resources {
      cores  = 2
      memory = 2
      core_fraction = 20
    }

    boot_disk {
      initialize_params {
        image_id = "fd8jvcoeij6u9se84dt5" # centos 7
        size     = 10
        type     = "network-hdd"
      }
    }

    network_interface {
      network_id = yandex_vpc_network.netology-net.id
      subnet_ids = [
        yandex_vpc_subnet.public.id,
      ]
      # Флаг nat true указывает что виртуалкам будет предоставлен публичный IP адрес.
      nat = true
    }

    metadata = {
      ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
    }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    zones = [
      "ru-central1-a",
    ]
  }

  deploy_policy {
    max_unavailable = 1
    max_creating    = 1
    max_expansion   = 1
    max_deleting    = 1
  }
}
