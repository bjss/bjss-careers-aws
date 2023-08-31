#!/usr/bin/env bash

set -euo pipefail

###########
# Terraform outputs useful values that come in handy in the pipeline.
# But how do we make them available to the pipeline?
# => This little script exports them to environment variables that GitHub jobs can read
###########

terraform_string_outputs="$(terraform show -json | jq -r '.values.outputs | to_entries[] | select(.value.type == "string") | "\(.key)=\(.value.value)"')"
for outvar in $terraform_string_outputs; do
  echo "exporting to pipeline: ${outvar}"
  echo "${outvar}" >> $GITHUB_OUTPUT
done
