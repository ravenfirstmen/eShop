#!/usr/bin/env bash

ROOT_DIR="$(dirname "$(dirname "$(readlink -fm "$0")")")"
APP_HOST_DIR="${ROOT_DIR}/src/eShop.AppHost/"

cd "${APP_HOST_DIR}" || exit

aspirate apply 
