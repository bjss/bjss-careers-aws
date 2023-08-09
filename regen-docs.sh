#!/usr/bin/env bash

set -euo pipefail


echo -e "\nRegenerating terraform documentation... $(date)\n"

npids=0

terraform_projects=$(find . -path "**/terraform/*" -type d -prune | sed -E "s/(.*\/terraform).*/\1/" | sort | uniq)
terraform_modules=$(find . -path "**/modules/*" -type d -prune | sed -E "s/(.*\/terraform).*/\1/" | sort | uniq)

for module in ${terraform_projects} ${terraform_modules}; do
  if [[ -f "${module}/.terraform-docs.yml" ]]; then
    config_file="${module}/.terraform-docs.yml"
  else
    config_file="$(git rev-parse --show-toplevel)/.terraform-docs.yml"
  fi
  terraform-docs markdown table --output-file README.md "${module}" -c "${config_file}" &
  pids[${npids}]=$!
  ((npids=npids+1))
done;

# wait for all background processes to complete before continuing
for pid in ${pids[*]}; do
  wait $pid
done

git add -A '**/README.md'

echo -e "\nterraform doc updates complete! $(date)\n"
