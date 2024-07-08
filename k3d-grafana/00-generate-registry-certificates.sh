#!/usr/bin/env bash

CERTS_VOLUME="$(pwd)/.certs"
REGISTRY_NAME="k3d-registry"
REGISTRY_DNS_NAME="${REGISTRY_NAME}.localhost"

mkdir -p "${CERTS_VOLUME}"

# CA
if [ ! -f "${CERTS_VOLUME}/${REGISTRY_NAME}-ca-key.pem" ]
then
  openssl genrsa -out "${CERTS_VOLUME}/${REGISTRY_NAME}-ca-key.pem" 4096
  openssl req -x509 -new -nodes -key "${CERTS_VOLUME}/${REGISTRY_NAME}-ca-key.pem" -sha256 -days 1826 \
      -out "${CERTS_VOLUME}/${REGISTRY_NAME}-ca.crt" \
      -subj "/CN=${REGISTRY_NAME}-ca/C=PT/ST=Braga/L=Famalicao/O=Casa"
fi


# Certificado
openssl genrsa -out "${CERTS_VOLUME}/${REGISTRY_NAME}-reg-key.pem" 4096
openssl req -new -key "${CERTS_VOLUME}/${REGISTRY_NAME}-reg-key.pem" \
    -out "${CERTS_VOLUME}/${REGISTRY_NAME}-reg.csr" \
    -subj "/CN=${REGISTRY_DNS_NAME}/C=PT/ST=Braga/L=Famalicao/O=Casa"

cat > "${CERTS_VOLUME}/${REGISTRY_NAME}.ext" <<- EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = localhost
DNS.2 = ${REGISTRY_DNS_NAME}
EOF

openssl x509 -req -in "${CERTS_VOLUME}/${REGISTRY_NAME}-reg.csr" \
  -CA "${CERTS_VOLUME}/${REGISTRY_NAME}-ca.crt" \
  -CAkey "${CERTS_VOLUME}/${REGISTRY_NAME}-ca-key.pem" \
  -out "${CERTS_VOLUME}/${REGISTRY_NAME}-reg.pem" \
  -days 825 -sha256 \
  -extfile "${CERTS_VOLUME}/${REGISTRY_NAME}.ext"
