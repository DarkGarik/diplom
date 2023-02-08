#!/usr/bin/env bash

set -e

master_ip=$(terraform output -json instance_group_masters_public_ips | jq -jc ".[0]")

ssh ubuntu@$master_ip "sudo cat /etc/kubernetes/admin.conf" > ~/.kube/config

sed -i -- "s/127.0.0.1/$master_ip/g" ~/.kube/config

chmod 600 ~/.kube/config