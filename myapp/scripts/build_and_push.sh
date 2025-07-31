#!/usr/bin/env bash
set -euo pipefail

echo "Building Docker image..."
IMAGE="sanikaa5/node-app:$GIT_COMMIT"
docker build -t $IMAGE .

echo "Pushing to DockerHub..."
docker push $IMAGE

