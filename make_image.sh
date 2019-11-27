#!/usr/bin/env bash

docker build -t rock960 ./
mkdir -p data
docker run -it --rm --privileged -v `pwd`/data/:/data rock960
