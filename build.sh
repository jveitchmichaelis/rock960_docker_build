#!/usr/bin/env bash

cd /rock960dev/rootfs

RELEASE=stretch TARGET=desktop ARCH=arm64 ./mk-base-debian.sh
TARGET=desktop ARCH=arm64 ./mk-rootfs.sh
./mk-image.sh

cd /rock960dev/
./build/mk-image.sh -c rk3399 -t system -r rootfs/linaro-rootfs.img
cp out/system.img /data/