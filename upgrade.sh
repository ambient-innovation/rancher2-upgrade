#!/bin/sh

# This is the file that actually executes the rancher CLI command. It uses the rancher CLI to run kubectl
# and patch the deployment.
# Execute it like "upgrade.sh [namespace] [deployment]
# Example: upgrade.sh default my-website
# It will patch the deployment with an enviroment variable FORCE_RESTART_AT and assign it the gitlab pipeline ID.
# The only reason for this is to have an environment variable that changes, which will force kubernetes to
# re-pull the image.

echo "Upgrading deployment $2 in namespace $1 ..."

rancher kubectl \
    --namespace=$1 \
    patch 'deployment.apps' $2 \
    --type=strategic \
    -p '{"spec":{"template":{"spec":{"containers":[{"name":"'$2'","env":[{"name":"FORCE_RESTART_AT","value":"'$(date --utc -Iseconds)'"}]}]}}}}'
