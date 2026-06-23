#!/bin/bash

set -euo pipefail

IMAGE=go60-zmk-config-podman
BRANCH="${1:-main}"

podman build -t "$IMAGE" .
podman run --rm -v "$PWD:/config:z" -e UID="$(id -u)" -e GID="$(id -g)" -e BRANCH="$BRANCH" "$IMAGE"
