#!/usr/bin/env bash

set -euo pipefail

localDir="$(dirname ${BASH_SOURCE[0]})"

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl apply -f ${localDir}/../manifests/service.yaml
kubectl apply -f ${localDir}/../manifests/deployment.yaml
kubectl apply -f ${localDir}/../manifests/horizontalpodautoscaler.yaml

# create a route53 private zone DNS entry for newly created load balancer
loadBalancerUrl="$(kubectl get service imgproxy -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')"
loadBalancerName="${loadBalancerUrl%%-*}"
loadBalancerCanonicalHostedZoneId="$(aws elbv2 describe-load-balancers --names ${loadBalancerName} --query "LoadBalancers[0].CanonicalHostedZoneId" --output text)"

environment="${1:-$(terraform show -json | jq -r .values.outputs.environment.value)}"
environment_dns="imgproxy.${environment}.private.techtest.bjsscareers.co.uk"
privateHostedZone="${2:-$(terraform show -json | jq -r .values.outputs.private_hosted_zone_id.value)}"

# create new record

aws route53 change-resource-record-sets \
  --hosted-zone-id ${privateHostedZone} \
  --change-batch '{"Changes":[{"Action":"UPSERT","ResourceRecordSet":{"Name":"'${environment_dns}'","Type":"A","AliasTarget":{"DNSName":"'${loadBalancerUrl}'","HostedZoneId": "'${loadBalancerCanonicalHostedZoneId}'","EvaluateTargetHealth":true}}}]}'
