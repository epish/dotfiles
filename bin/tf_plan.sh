#!/bin/bash
# run TF plan with Vault token and AWS creds with parallelism

set -e

# if [ -z "$1" ]; then
#     echo "No env supplied"
#     exit 2
# fi


PATH_CRED="$HOME/.config/"

# Gcloud
# if [ -f "${PATH_CRED}/credentials.json" ]; then
#     export GOOGLE_APPLICATION_CREDENTIALS="${PATH_CRED}/application_default_credentials.json"
# fi

# if [ -f "${PATH_CRED}/.vault_token" ]; then
#     export VAULT_TOKEN=$(cat ${PATH_CRED}/.vault_token)
# fi

# ENV=$1
# shift
# if [[ "$ENV"=="dev" || "$ENV"=="stage" || "$ENV"="prod" ]]; then
#     echo "selecting $ENV workspace"
# else 
#     echo "wrong env provided: $ENV"
#     exit 2
# fi

if [ -f "${PATH_CRED}/.aws" ]; then
    . "${PATH_CRED}/.aws"
fi

#terraform workspace select $ENV
terraform get
terraform validate
terraform plan