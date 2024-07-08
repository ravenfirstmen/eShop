#!/usr/bin/env bash

CLUSTER_NAME=${1:-"eshop"}
SHARED_VOLUME=$(pwd)/.volume
CERTS_VOLUME=$(pwd)/.certs
REGISTRY_NAME="k3d-registry.localhost"

docker network disconnect -f "k3d-${CLUSTER_NAME}" ${REGISTRY_NAME}
docker container stop ${REGISTRY_NAME} && docker container rm -v ${REGISTRY_NAME} 
k3d cluster delete "${CLUSTER_NAME}"

rm -rf "${SHARED_VOLUME}"
#rm -rf "${CERTS_VOLUME}"


