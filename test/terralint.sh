#!/usr/bin/env bash

set -euo pipefail  # safe scripting

PROJECT=${1:-application}

cd "${PROJECT}"

if terraform fmt -recursive -check; then
  echo -e "\nTerraform linting of ${PROJECT} configuration successful [ OK ]\n"
  exit 0
else
  echo -e "\nTerraform linting of ${PROJECT} configuration failed. Fix locally then push a new commit [ FAIL ]\n"
  exit 1
fi
