output "instance_group_masters_public_ips" {
  description = "Public IP addresses for master-nodes"
  value = yandex_compute_instance_group.k8s-masters.instances.*.network_interface.0.nat_ip_address
}

output "instance_group_masters_private_ips" {
  description = "Private IP addresses for master-nodes"
  value = yandex_compute_instance_group.k8s-masters.instances.*.network_interface.0.ip_address
}

output "instance_group_workers_public_ips" {
  description = "Public IP addresses for worker-nodes"
  value = yandex_compute_instance_group.k8s-workers.instances.*.network_interface.0.nat_ip_address
}

output "instance_group_workers_private_ips" {
  description = "Private IP addresses for worker-nodes"
  value = yandex_compute_instance_group.k8s-workers.instances.*.network_interface.0.ip_address
}
output "instance_group_jenkins_masters_public_ips" {
  description = "Public IP addresses for jenkins-masters"
  value = yandex_compute_instance_group.jenkins-masters.instances.*.network_interface.0.nat_ip_address
}
output "instance_group_jenkins-agents_public_ips" {
  description = "Public IP addresses for jenkins-agents"
  value = yandex_compute_instance_group.jenkins-agents.instances.*.network_interface.0.nat_ip_address
}
