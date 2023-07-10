#!/bin/bash

cmd=$1

# constants
IMAGE_NAME="model_reconstruct3d"
IMAGE_TAG=$(git describe --always)

if [[ -z "$cmd" ]]; then
    echo "Missing command"
    exit 1
fi

run_reconstruct3d() {
    port=$
    if [[ -z "$port" ]]; then
        echo "Missing port"
        exit 1
    fi

    docker build -f nerfstudio/Dockerfile -t $IMAGE_NAME:$IMAGE_TAG .
    IMAGE_NAME=$IMAGE_NAME IMAGE_TAG=$IMAGE_TAG \
        docker-compose -f docker-compose.yml up -d
}

shift

case $cmd in
run_reconstruct3d)
    run_reconstruct3d "$@"
    ;;
*)
    echo -n "Unknown command: $cmd"
    exit 1
    ;;
esac