#!/usr/bin/env bash

CLUSTER_NAME=${1:-"eshop"}
SHARED_VOLUME="$(pwd)/.volume"
CERTS_VOLUME="$(pwd)/.certs"
REGISTRY_NAME="k3d-registry.localhost"
REGISTRY_PORT="5443"

mkdir -p "${SHARED_VOLUME}"
mkdir -p "${CERTS_VOLUME}"


# this is mandatory in order to fluent-bit work
if [ -f /etc/machine-id ]; then
  cp -f /etc/machine-id "${SHARED_VOLUME}/"
else
  uuidgen -r -x | tr -d '-' > "${SHARED_VOLUME}/machine-id"
fi


docker run --detach --restart=always \
 --name "${REGISTRY_NAME}" \
 --volume "${CERTS_VOLUME}":/certs \
 --env REGISTRY_HTTP_ADDR=0.0.0.0:${REGISTRY_PORT} \
 --env REGISTRY_HTTP_TLS_CERTIFICATE=/certs/k3d-registry-reg.pem \
 --env REGISTRY_HTTP_TLS_KEY=/certs/k3d-registry-reg-key.pem \
 --publish ${REGISTRY_PORT}:${REGISTRY_PORT} \
 registry:2

export K3D_FIX_MOUNTS=1
k3d cluster create --config cluster-config.yaml 

docker network connect "k3d-${CLUSTER_NAME}" ${REGISTRY_NAME}
