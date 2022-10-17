#!/bin/bash
# Build script
set -o pipefail
build_tag=ts
name=telemetry-service
node=node
org=any

docker build -f ./Dockerfile.Build -t ${org}/${name}:${build_tag}-build . 
docker run --name=${name}-${build_tag}-build ${org}/${name}:${build_tag}-build 
containerid=$(docker ps -aqf "name=${name}-${build_tag}-build")
docker cp $containerid:/opt/telemetry-service.zip telemetry-service.zip
docker rm $containerid
echo {\"image_name\" : \"${name}\", \"image_tag\" : \"${build_tag}\", \"node_name\" : \"$node\"} > metadata.json
