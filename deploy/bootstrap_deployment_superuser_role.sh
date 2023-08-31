#!/usr/bin/env bash

###########
# Used to generate the initial superuser role in the AWS account.
#
# Deployments of the application use an IAM Role with limited permissions and a permission boundary.
#
# But how do we create the IAM Role that Terraform uses before Terraform runs?
#
# => We create it here, via the CLI.
###########

set -euo pipefail  # safe scripting

declare red="\033[0;31m";
declare yellow="\033[0;33m";
declare cyan="\033[0;36m";
declare nc="\033[0m"; # No Color
declare bold="\033[1m";

echo -e "\n${yellow}Before running this process you should assume the ${cyan}Administrator${yellow} role in the account in which you want to create the account-level deploy role${nc}"
echo -e "\n${red}CONFIRM:${cyan} Are you SURE you are in the right AWS account?${nc}\n"

read -r confirmation

if [[ ! "${confirmation^^}" =~ ^(Y|YES)$ ]]; then
  echo -e "\nAborted [ ${red}FAIL${nc} ]\n"
  exit 1
fi

superuser_role="aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_Administrator_13edb3b19d3fd0cc"
document="{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::322411843910:role/${superuser_role}\"},\"Action\":\"sts:AssumeRole\"}]}"

if ! aws iam create-role \
  --role-name TECHTESTAccountDeployRole \
  --assume-role-policy-document "${document}" \
  --output yaml
then
  echo -e "\nCouldn't create role [ ${red}FAIL${nc} ]\n"
  exit 1
fi

if ! aws iam attach-role-policy \
  --role-name TECHTESTAccountDeployRole \
  --policy-arn "arn:aws:iam::aws:policy/AdministratorAccess"
then
  echo -e "\nCouldn't attach managed policy [ ${red}FAIL${nc} ]\n"
  exit 1
fi

echo -e "\nRole created [ ${yellow}OK${nc} ]\n"
exit 0
