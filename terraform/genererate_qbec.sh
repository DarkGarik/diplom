#!/bin/bash

set -e

cat << EOF
apiVersion: qbec.io/v1alpha1
kind: App
metadata:
  name: myapp
spec:
  environments:
    default:
      defaultNamespace: stage
EOF
printf "      server: https://"
terraform output -json instance_group_masters_public_ips | jq -j ".[1-1]"
printf ":6443"
printf "\n"
cat << EOF
  vars:
    external:
      - name: tag
        default: latest
EOF
