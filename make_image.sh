#!/usr/env/bin bash

docker build -t ./ rock960
mkdir data
docker run --privileged -v `pwd`/data/:/data rock960 /build.sh
