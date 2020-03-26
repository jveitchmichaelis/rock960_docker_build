#!/usr/bin/env bash

if [ $# -eq 0 ]; then
  cd /rock960dev/rootfs
  RELEASE=buster TARGET=desktop ARCH=arm64 ./mk-base-debian.sh
  RELEASE=buster TARGET=desktop ARCH=arm64 ./mk-rootfs.sh
  RELEASE=buster TARGET=desktop ARCH=arm64 ./mk-rootfs-extra.sh

  cd /rock960dev/kernel

  cd /rock960dev/rootfs
  ./mk-image.sh

  cd /rock960dev/

  ./build/mk-image.sh -c rk3399 -t system -r rootfs/linaro-rootfs.img
  cp out/system.img /data/

  /usr/bin/env bash
fi

$1

exit 0
