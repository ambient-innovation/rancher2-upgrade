# This is simply the rancher CLI plus kubectl

# Adapted docker setup from https://hub.docker.com/r/diemscott/rancher-cli-k8s/~/dockerfile/
FROM lachlanevenson/k8s-kubectl:v1.11.6 AS k8scli
FROM rancher/cli:v2.0.4
COPY --from=k8scli /usr/local/bin/kubectl /usr/local/bin

# We add envsubst which allows to replace environment variables, which is very handy when replacing congig
# in Kubernetes yml files.
ENV BUILD_DEPS="gettext"  \
    RUNTIME_DEPS="libintl"

RUN set -x && \
    apk add --update $RUNTIME_DEPS && \
    apk add --virtual build_deps $BUILD_DEPS &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

COPY docker-entrypoint.sh /usr/local/bin/
COPY upgrade.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]