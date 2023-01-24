resource "yandex_vpc_network" "netology-net" {
  name = "netology-network"
}

resource "yandex_vpc_subnet" "public" {
  v4_cidr_blocks = ["192.168.10.0/24"]
  network_id     = "${yandex_vpc_network.netology-net.id}"
  name = "public"
}

resource "yandex_vpc_subnet" "private" {
  v4_cidr_blocks = ["192.168.20.0/24"]
  network_id     = "${yandex_vpc_network.netology-net.id}"
  name = "private"
  # route_table_id = "${yandex_vpc_route_table.netology-route.id}"
}

# resource "yandex_vpc_route_table" "netology-route" {
#   network_id = "${yandex_vpc_network.netology-net.id}"
#   name = "net-route"

#   static_route {
#     destination_prefix = "0.0.0.0/0"
#     next_hop_address   = "192.168.10.254"
#   }
# }