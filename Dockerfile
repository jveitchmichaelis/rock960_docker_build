FROM ubuntu:16.04
RUN apt-get update

RUN apt-get install -qq repo git-core gitk git-gui gcc-arm-linux-gnueabihf u-boot-tools device-tree-compiler gcc-aarch64-linux-gnu mtools parted pv libssl-dev
RUN apt-get install -qq binfmt-support qemu-user-static python-dbus python-debian python-parted python-yaml apt-utils wget cpio bzip2 gdisk sudo
RUN apt-get install  -qq bison flex make autoconf bc dosfstools xz-utils wget ccache 

RUN mkdir rock960dev

RUN cd rock960dev && repo init -u https://github.com/96rocks/manifests -m rock960.xml
RUN cd rock960dev && repo sync
RUN cd rock960dev && repo start 96rocks/release-4.4-rock960 --all
#RUN cd rock960dev/kernel && git checkout release-4.4-rock960

RUN cp rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig rock960dev/kernel/.config

# Get overlay support for Docker
RUN sed -i "s/CONFIG_OVERLAY_FS=m/CONFIG_OVERLAY_FS=y/g" rock960dev/kernel/.config
RUN cd rock960dev/kernel && make oldconfig

# Build the kernel
RUN cd rock960dev && build/mk-kernel.sh rock960ab
RUN cd rock960dev && build/mk-uboot.sh rock960ab

# Build Ubuntu
RUN wget http://launchpadlibrarian.net/109052632/python-support_1.0.15_all.deb
RUN dpkg -i python-support_1.0.15_all.deb

RUN cd rock960dev/rootfs && dpkg -i ubuntu-build-service/packages/*
RUN cd rock960dev/rootfs && apt-get install -f

# Can't do this because we can't do privileged shit inside Docker..
#RUN cd rock960dev/rootfs && RELEASE=stretch TARGET=base ARCH=arm64 ./mk-base-debian.sh && ./mk-rootfs.sh

# Build the image when the container is run
COPY build.sh build.sh
RUN chmod +x build.sh

ENTRYPOINT ["/build.sh"]
