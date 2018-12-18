# ai-rancher2-upgrade

Allows you to upgrade existing workloads in Rancher 2 in your CI process.
This image will use the Rancher CLI to change an environment variable, which 
will cause kubernetes to re-pull the docker image. 

## Usage

1. Specify the following environment variables (e.g. in Gitlab > CI/CD > Variables"):
- RANCHER2_ACCESS_KEY (From Rancher 2 "API & Keys")
- RANCHER2_SECRET_KEY (From Rancher 2 "API & Keys")
- RANCHER2_SERVER_URL (The URL of your Rancher 2 deployment)
- RANCHER2_PROJECT_ID ("View in API" next to project, then the property "id")

2. Run the docker-entrypoint.sh (gitlab will not do this automatically). This will create the
cli2.json

3. Execute "patch.de [namespace] [workload]" script for each deployment, you want to upgrade. You must specify the workload including its type like "deployment/name" or "cronjob/name".

Sample gitlab-ci.yml:

```
deploy to test:
  stage: deploy
  image: ambientinnovation/rancher2-upgrade:v1.0.0
  variables:
    GIT_STRATEGY: none
  only:
    - develop
  script:
    - /usr/local/bin/docker-entrypoint.sh # Authenticates with rancher API
    - /usr/local/bin/patch.sh default deployment/website # Triggers the actual upgrade
```

## Development

This project is hosted at https://github.com/ambient-innovation/rancher2-upgrade

The docker image is hosted on dockerhub at https://hub.docker.com/r/ambientinnovation/rancher2-upgrade.

To make changes, proceed as follows:

1. Make your changes to the code, just push to the repo. It is configured as automated build. The branch
"master" will receive the tag "latest" and each Git Tag will create a corresponding docker tag.
