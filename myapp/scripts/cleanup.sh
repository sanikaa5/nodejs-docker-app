#!/usr/bin/env bash
set -euo pipefail

echo "Cleaning up Docker..."
docker image prune -f
docker container prune -f
docker network prune -f

