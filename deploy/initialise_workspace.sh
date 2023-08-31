#!/usr/bin/env bash

set -euo pipefail

###########
# The 'Application' Terraform Configuration deploys a single image resizing application environment.
#
# Every environment is identical to every other environment, but you can have as many of them as you please
# (or as many as your AWS account limits will allow).
#
# The name of the environment is assumed from the name of the Terraform Workspace selected at deployment-time.
# This little script selects the workspace name requested in the CICD pipeline, creating it first if required.
###########

REQUIRED_WORKSPACE=${1:-default}

if ! terraform workspace select "${REQUIRED_WORKSPACE}"; then
  echo "creating new terraform workspace ${REQUIRED_WORKSPACE}..."
  echo "new_environment=yes" >> ${GITHUB_OUTPUT:-/dev/null}
  terraform workspace new "${REQUIRED_WORKSPACE}"
else
  echo "new_environment=no" >> ${GITHUB_OUTPUT:-/dev/null}
fi

terraform workspace select "${REQUIRED_WORKSPACE}"
