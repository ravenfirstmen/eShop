#!/usr/bin/env bash

CERTS_VOLUME="$(pwd)/.certs"
REGISTRY_NAME="k3d-registry"

if [ ! -f "${CERTS_VOLUME}/${REGISTRY_NAME}-ca.crt" ]
then
  echo "Could not find ${CERTS_VOLUME}/${REGISTRY_NAME}-ca.crt. Please generate it first!"
  exit
fi

if [ "$EUID" -ne 0 ]
  then echo "Please run this script as sudo!"
  exit
fi

cp "${CERTS_VOLUME}/${REGISTRY_NAME}-ca.crt" /usr/local/share/ca-certificates
update-ca-certificates
