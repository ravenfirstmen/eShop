#!/usr/bin/env bash

ROOT_DIR="$(dirname "$(dirname "$(readlink -fm "$0")")")"
APP_HOST_DIR="${ROOT_DIR}/src/eShop.AppHost/"
REGISTRY="k3d-registry.localhost:5443"
cd "${APP_HOST_DIR}" || exit

export ESHOP_USE_HTTP_ENDPOINTS=1
aspirate generate --disable-secrets \
  --container-registry ${REGISTRY} 
#   
# declare -a images=(
#   webapp
#   webhooksclient
#   mobile-bff
#   webhooks-api
#   payment-processor
#   order-processor
#   ordering-api
#   catalog-api
#   basket-api
#   identity-api
# )
  
#for image in "${images[@]}"
#do
#  docker tag "${image}:latest" "${REGISTRY}/${image}:latest"
#  docker push "${REGISTRY}/${image}:latest"
#done
