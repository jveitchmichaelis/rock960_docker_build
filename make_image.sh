#!/usr/bin/env bash

docker build -t rock960 ./
mkdir -p data
docker run -it --rm --storage-opt size=25G --privileged -v `pwd`/data/:/data rock960
