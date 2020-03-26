FROM ubuntu:16.04
RUN apt-get update

RUN apt-get install -qq repo git-core gitk git-gui gcc-arm-linux-gnueabihf u-boot-tools device-tree-compiler gcc-aarch64-linux-gnu mtools parted pv libssl-dev
RUN apt-get install -qq binfmt-support qemu-user-static python-dbus python-debian python-parted python-yaml apt-utils wget cpio bzip2 gdisk sudo
RUN apt-get install  -qq bison flex make autoconf bc dosfstools xz-utils wget ccache 

RUN mkdir rock960dev

RUN cd rock960dev && repo init -u https://github.com/jveitchmichaelis/rock960_docker_build -m manifest.xml
RUN cd rock960dev && repo sync

#Modify the kernel config
RUN sed -i "s/CONFIG_DEFAULT_HOSTNAME=\"localhost\"/CONFIG_DEFAULT_HOSTNAME=\"rock960\"/g" rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig

# Make sure that all modules for Docker are installed
#RUN echo "CONFIG_OVERLAY_FS=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_BRIDGE_NETFILTER=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
RUN echo  "CONFIG_NF_NAT=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_NET_NS=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_PID_NS=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_IPC_NS=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_UTS_NS=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_KEYS=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_BRIDGE=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_IOSCHED_CFQ=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_FAIR_GROUP_SCHED=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_EXT3_FS=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_EXT3_FS_XATTR=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_EXT3_FS_POSIX_ACL=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_EXT3_FS_SECURITY=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_MEMCG=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_VETH=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_NF_NAT_IPV4=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_IP_NF_FILTER=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_IP_NF_TARGET_MASQUERADE=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_NETFILTER_XT_MATCH_IPVS=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_IP_NF_NAT=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_NF_NAT_NEEDED=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_POSIX_MQUEUE=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_CGROUP_PIDS=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_MEMCG_SWAP=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_MEMCG_SWAP_ENABLED=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_MEMCG_KMEM=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_BLK_CGROUP=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_BLK_DEV_THROTTLING=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_CFQ_GROUP_IOSCHED=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_CGROUP_PERF=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_CGROUP_HUGETLB=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_NET_CLS_CGROUP=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_CGROUP_NET_PRIO=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_RT_GROUP_SCHED=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_IP_NF_TARGET_REDIRECT=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_IP_VS=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_IP_VS_NFCT=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_IP_VS_PROTO_TCP=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_IP_VS_PROTO_UDP=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_IP_VS_RR=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_VXLAN=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_BRIDGE_VLAN_FILTERING=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_INET_ESP=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_IPVLAN=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_MACVLAN=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_DUMMY=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_NF_NAT_FTP=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_NF_CONNTRACK_FTP=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_NF_NAT_TFTP=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_NF_CONNTRACK_TFTP=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_AUFS_FS=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_BTRFS_FS=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_BTRFS_FS_POSIX_ACL=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_BLK_DEV_DM=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
#    && echo  "CONFIG_DM_THIN_PROVISIONING=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_CRYPTO=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_CRYPTO_AEAD=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_CRYPTO_GCM=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_CRYPTO_SEQIV=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_CRYPTO_GHASH=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_XFRM=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_XFRM_ALGO=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig \
    && echo  "CONFIG_INET_XFRM_MODE_TRANSPORT=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig

#RUN echo "CONFIG_USB_NET_AX88179_178A=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig
#RUN echo "CONFIG_USB_NET_RNDIS_WLAN=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig
#RUN echo "CONFIG_WL_ROCKCHIP=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig
#RUN echo "CONFIG_WIFI_LOAD_DRIVER_WHEN_KERNEL_BOOTUP=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig

# Store kernel config
RUN echo "CONFIG_IKCONFIG=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig
RUN echo "CONFIG_LEDS_PCA9532=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig
# Need newer Linux... 
# RUN echo "CONFIG_BME680=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig
# RUN echo "CONFIG_SPS30=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig
RUN echo "CONFIG_USB_LED=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig
RUN echo "CONFIG_USB_LED_TRIG=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig
RUN echo "CONFIG_IKCONFIG_PROC=y" >> rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig

COPY check_config.sh rock960dev/check_config.sh
RUN chmod +x rock960dev/check_config.sh
RUN rock960dev/check_config.sh rock960dev/kernel/arch/arm64/configs/rockchip_linux_defconfig

COPY rock960-model-ab-linux.dts rock960dev/kernel/arch/arm64/boot/dts/rockchip/rock960-model-ab-linux.dts

# Build the kernel
RUN apt-get -qq install kmod dpkg-dev
RUN cd rock960dev/kernel && touch .scmversion
COPY mk-kernel.sh rock960dev/build/mk-kernel.sh
RUN cd rock960dev && build/mk-kernel.sh rock960ab
RUN cd rock960dev && build/mk-uboot.sh rock960ab

# Build Ubuntu
RUN wget http://launchpadlibrarian.net/109052632/python-support_1.0.15_all.deb
RUN dpkg -i python-support_1.0.15_all.deb

RUN cd rock960dev/rootfs && dpkg -i ubuntu-build-service/packages/*
RUN cd rock960dev/rootfs && apt-get install -f

# Overwrite the rootfs builder with some of our own stuff
COPY mk-rootfs-extra.sh rock960dev/rootfs/mk-rootfs-extra.sh
RUN chmod +x rock960dev/rootfs/mk-rootfs-extra.sh

COPY mk-rootfs-buster.sh rock960dev/rootfs/mk-rootfs-buster.sh
RUN chmod +x rock960dev/rootfs/mk-rootfs-buster.sh

# Can't do this because we can't do privileged shit inside Docker..
#RUN cd rock960dev/rootfs && RELEASE=stretch TARGET=base ARCH=arm64 ./mk-base-debian.sh

# Build the image when the container is run
COPY build.sh build.sh
RUN chmod +x build.sh

RUN apt-get -qq install nano vim

ENTRYPOINT ["/build.sh"]
