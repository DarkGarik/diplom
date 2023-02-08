#!/bin/bash

set -e

printf "[all]\n"

for num in 1
do
printf "master-$num   ansible_host="
terraform output -json instance_group_masters_public_ips | jq -j ".[$num-1]"
printf "   ip="
terraform output -json instance_group_masters_private_ips | jq -j ".[$num-1]"
printf "   etcd_member_name=etcd-$num\n"
done

for num in 1 2
do
printf "worker-$num   ansible_host="
terraform output -json instance_group_workers_public_ips | jq -j ".[$num-1]"
printf "   ip="
terraform output -json instance_group_workers_private_ips | jq -j ".[$num-1]"
printf "\n"
done

printf "\n[all:vars]\n"
printf "ansible_user=ubuntu\n"
printf "supplementary_addresses_in_ssl_keys='"
terraform output -json instance_group_masters_public_ips | jq -cj '.'
printf "'\n\n"

cat << EOF
[kube-master]
master-1


[etcd]
master-1


[kube-node]
worker-1
worker-2


[kube-worker]
worker-1
worker-2


[k8s-cluster:children]
kube-master
kube-node
EOF