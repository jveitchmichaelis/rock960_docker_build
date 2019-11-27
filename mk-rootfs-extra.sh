#!/bin/bash -e

# Directory contains the target rootfs
TARGET_ROOTFS_DIR="binary"

if [ ! $ARCH ]; then
        ARCH='arm64'
fi
if [ ! $VERSION ]; then
        VERSION="debug"
fi

if [ ! -e linaro-stretch-alip-*.tar.gz ]; then
        echo "\033[36m Run mk-base-debian.sh first \033[0m"
fi

echo -e "\033[36m Change root.....................\033[0m"
sudo mount -o bind /dev $TARGET_ROOTFS_DIR/dev

cp /rock960dev/*.deb /data
rm /rock960dev/*dbg*.deb
cp /rock960dev/*.deb $TARGET_ROOTFS_DIR

cat <<EOF | sudo chroot $TARGET_ROOTFS_DIR

#-------------- Generating ssh keys------------
ssh-keygen -A

apt-get -qq install avahi-daemon

#----- Install linux kernel and modules, then remove
dpkg -i *.deb
rm *.deb

#--------------Installing Docker-------------
curl -sSL https://get.docker.com | sh
usermod -aG docker linaro

#--------------Disable WiFi power management-------------
touch /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
echo -e "[connection]\nwifi.powersave = 2\n" > /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf

echo -e "* * * * * root /sbin/iw wlan0 set power_save off" > /etc/cron.d/wifi_powersave

EOF

sudo umount $TARGET_ROOTFS_DIR/dev
