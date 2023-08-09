#!/usr/bin/env bash

set -euo pipefail

k8sCluster="${1:-$(terraform show -json | jq -r .values.outputs.k8s_cluster_name.value)}"

if aws eks update-kubeconfig \
  --region eu-west-2 \
  --name ${k8sCluster}
then
  echo -e "Configured k8s for cluster ${k8sCluster}"
else
  echo -e "Failed to configure k8s for cluster ${k8sCluster}"
fi
