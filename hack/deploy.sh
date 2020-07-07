#!/bin/bash

set -xe

IMAGE_NAME="quay.io/fidencio/test"

if "${TRAVIS_BRANCH}" == "master"; then
	TAG="latest"
else
	#TAG="$(echo ${TRAVIS_BRANCH} | awk '{print $2}' FS='-')"
	TAG="4.89"
fi

docker login \
	--username="${QUAY_USERNAME}" \
	--password="${QUAY_PASSWORD}" \
	quay.io

docker buildx build \
	--push \
	--platform="linux/amd64,linux/ppc64le" \
	--tag "${IMAGE_NAME}:${TAG}" \
	.
