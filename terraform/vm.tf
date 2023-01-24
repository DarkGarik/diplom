# resource "yandex_compute_instance" "nat" {
#   name = "nat-netology"

#   resources {
#     cores  = 2
#     memory = 2
#   }

#   boot_disk {
#     initialize_params {
#       image_id = "fd8o8aph4t4pdisf1fio"
#     }
#   }

#   network_interface {
#     subnet_id = "${yandex_vpc_subnet.public.id}"
#     ip_address = "192.168.10.254"
#     nat       = true
#   }

#   metadata = {
#     ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
#   }
# }

# resource "yandex_compute_instance" "vm1" {
#   name = "vm1"

#   resources {
#     cores  = 2
#     memory = 2
#   }

#   boot_disk {
#     initialize_params {
#       image_id = "fd8smb7fj0o91i68s15v"
#     }
#   }

#   network_interface {
#     subnet_id = "${yandex_vpc_subnet.public.id}"
#     nat = true
#   }

#   metadata = {
#     ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
#   }
# }

# resource "yandex_compute_instance" "vm2" {
#   name = "vm2"

#   resources {
#     cores  = 2
#     memory = 2
#   }

#   boot_disk {
#     initialize_params {
#       image_id = "fd8smb7fj0o91i68s15v"
#     }
#   }

#   network_interface {
#     subnet_id = "${yandex_vpc_subnet.private.id}"
#   }

#   metadata = {
#     ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
#   }
# }