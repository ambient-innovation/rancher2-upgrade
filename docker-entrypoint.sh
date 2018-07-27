#!/bin/sh

# This entrypoint creates a cli2.json file which rancher CLI uses to authenticate with rancher and
# select the current project. This is necessary, because the current rancher CLI has no real non-interactive mode.
# Otherwise we could directly use "rancher login" in our CI pipline. But if there are several projects, the CLI
# will ask us to select a project, see https://github.com/rancher/rancher/issues/14448

echo Writing rancher CLI2 file ...

mkdir ~/.rancher
echo "{
  \"Servers\":
  {
    \"rancherDefault\":
    {
      \"accessKey\":\"$RANCHER2_ACCESS_KEY\",
      \"secretKey\":\"$RANCHER2_SECRET_KEY\",
      \"tokenKey\":\"$RANCHER2_ACCESS_KEY:$RANCHER2_SECRET_KEY\",
      \"url\":\"$RANCHER2_SERVER_URL\",
      \"project\":\"$RANCHER2_PROJECT_ID\",
      \"cacert\":\"\"
    }
  },
  \"CurrentServer\":\"rancherDefault\"
}" > ~/.rancher/cli2.json

echo Done

# Debug output
# cat ~/.rancher/cli2.json

# Since this is a "configuration data" entrypoint, we now want to execute the actual command.
# See https://success.docker.com/article/use-a-script-to-initialize-stateful-container-data
exec "$@"