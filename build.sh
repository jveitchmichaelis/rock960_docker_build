#!/usr/bin/env bash

if [ $# -eq 0 ]; then
  cd /rock960dev/rootfs
  
  # Fix packages (don't install gnome... and install i2c-tools, git)
  sed -i '$ d' ubuntu-build-service/buster-desktop-arm64/customization/package-lists/linaro.list.chroot
  echo "i2c-tools" >> ubuntu-build-service/buster-desktop-arm64/customization/package-lists/linaro.list.chroot
  echo "git" >> ubuntu-build-service/buster-desktop-arm64/customization/package-lists/linaro.list.chroot

  RELEASE=buster TARGET=desktop ARCH=arm64 ./mk-base-debian.sh
  RELEASE=buster TARGET=desktop ARCH=arm64 ./mk-rootfs.sh
  RELEASE=buster TARGET=desktop ARCH=arm64 ./mk-rootfs-extra.sh

  if [ $? -eq 0 ]; then
    echo OK
  else
    exit 1
  fi

  cd /rock960dev/kernel

  cd /rock960dev/rootfs
  sed "s/seek=4000/seek=4500/g" -i ./mk-image.sh
  ./mk-image.sh

  if [ $? -eq 0 ]; then
    echo OK
  else
    exit 1
  fi

  cd /rock960dev/

  ./build/mk-image.sh -c rk3399 -t system -r rootfs/linaro-rootfs.img

  if [ $? -eq 0 ]; then
    echo OK
  else
    exit 1
  fi

  cp out/system.img /data/
  #/usr/bin/env bash
fi

$1

exit 0
