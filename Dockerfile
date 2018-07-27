# This is simply the rancher CLI plus kubectl
FROM diemscott/rancher-cli-k8s:v2.0.2

COPY docker-entrypoint.sh /usr/local/bin/
COPY upgrade.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]