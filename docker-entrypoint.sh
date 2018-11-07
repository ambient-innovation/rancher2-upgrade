#!/bin/sh

# Login to rancher and select project
echo Logging into rancher...

rancher login $RANCHER2_SERVER_URL --token $RANCHER2_ACCESS_KEY:$RANCHER2_SECRET_KEY --context $RANCHER2_PROJECT_ID

# Since this is a "configuration data" entrypoint, we now want to execute the actual command.
# See https://success.docker.com/article/use-a-script-to-initialize-stateful-container-data
exec "$@"
