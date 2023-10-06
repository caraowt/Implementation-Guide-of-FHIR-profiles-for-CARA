#!/usr/bin/env bash

set -ex

mkdir -p output

docker build \
  -t ig-builder \
  .

docker run --rm \
  -u "$(id -u):$(id -g)" \
  -v "$(pwd)/output:/output/" \
  ig-builder
