#!/usr/bin/env bash
set -euo pipefail
: "${BRANCH:=main}"

echo "Checking out $BRANCH from moergo-sc/zmk" >&2
cd /src
git fetch origin
git checkout -q --detach "$BRANCH"

echo 'Building Go60 firmware' >&2
cd /config
nix-build ./config --arg firmware 'import /src/default.nix {}' -j2 -o /tmp/combined --show-trace
install -o "$UID" -g "$GID" /tmp/combined/go60.uf2 ./go60.uf2
