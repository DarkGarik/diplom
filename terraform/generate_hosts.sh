#!/bin/bash

set -e

cat << EOF
---
all:
  hosts:
    jenkins-master-01:
EOF
printf "      ansible_host: "
printf '"'
terraform output -json instance_group_jenkins_masters_public_ips | jq -j ".[1-1]"
printf '"'
printf "\n"
printf "    jenkins-agent-01:"
printf "\n"
printf "      ansible_host: "
printf '"'
terraform output -json instance_group_jenkins-agents_public_ips | jq -j ".[1-1]"
printf '"'
printf "\n"
cat << EOF
  children:
    jenkins:
      children:
        jenkins_masters:
          hosts:
            jenkins-master-01:
        jenkins_agents:
          hosts:
              jenkins-agent-01:
  vars:
    ansible_connection_type: paramiko
    ansible_user: centos
EOF
