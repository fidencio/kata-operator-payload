#!/bin/bash

set -xe

IMAGE_NAME="quay.io/fidencio/test"

if "${TRAVIS_BRANCH}" == "master"; then
	TAG="latest-${TRAVIS_CPU_ARCH}"
else
	TAG="$(echo ${TRAVIS_BRANCH} | awk '{print $2}' FS='-')-${TRAVIS_CPU_ARCH}"
fi

docker login \
	--username="${QUAY_USERNAME}" \
	--password="${QUAY_PASSWORD}" \
	quay.io

docker build \
	--tag "${IMAGE_NAME}:${TAG}" \
	--build-arg ARCH="${TRAVIS_CPU_ARCH}" \
	.

docker push "${IMAGE_NAME}:${TAG}"
