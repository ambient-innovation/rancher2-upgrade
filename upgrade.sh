#!/bin/sh

# This is deprecated. See patch.sh instead.

echo -e "\033[33mWARNING: This script is deprecated. Use patch.sh instead and specify the workload type.\033[0m"
echo -e "\033[33mE.g. 'upgrade.sh default web' becomes 'patch.sh default deployment/web'.\033[0m"
echo -e "\033[33mSpecifying the workload type allows this script to also upgrade cronjobs etc.\033[0m"
echo "Upgrading deployment $2 in namespace $1 ..."

rancher kubectl \
    --namespace=$1 \
    patch deployment $2 \
    --type=strategic \
    -p '{"spec":{"template":{"spec":{"containers":[{"name":"'$2'","env":[{"name":"FORCE_RESTART_AT","value":"'$(date --utc -Iseconds)'"}]}]}}}}'
