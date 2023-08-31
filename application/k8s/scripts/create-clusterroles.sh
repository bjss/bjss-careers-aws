#!/usr/bin/env bash

set -euo pipefail

localDir="$(dirname ${BASH_SOURCE[0]})"

kubectl apply -f ${localDir}/../manifests/clusterrole-techtest-readonly.yaml
kubectl apply -f ${localDir}/../manifests/clusterrolebinding-techtest-readonly.yaml
