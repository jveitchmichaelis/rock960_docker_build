## Build a Rock960 debian image inside Docker

This Dockerfile provides a development environment to build system images for the Rock960 dev board. The instructions are broadly identical to: http://rageworx.ddns.net/index.php/easy-way-to-build-rock960-arm64-system-image/

There are a few kernel configuration options that I've added to enable containerisation.

To run, simply run `make_image.sh` which will:

1. Build the Docker container
2. Make a folder called `data` in the current folder
3. Run the container with the build script

Everything except deboostrap is run during the container build phase, so currently kernel options are hardcoded into the Dockerfile.

The container must be launched in privileged mode, otherwise certain build operations will fail. The Dockerfile will build a desktop environment using the default settings, with overlayfs support. If you want a base image, then simply change the target to "base".

The system image will be copied to the `data` folder where you can flash it as usual:

```
sudo rkdeveloptool db rk3399_loader_v1.12.112.bin
sudo rkdeveloptool wl 0 data/system.img
sudo rkdeveloptool rd
```

Or you can write this image to an SD card using [Etcher](https://www.balena.io/etcher/) or `dd`.

For some reason the official instructions neglect making kernel modules or installing them. I've had a long look to try and figure out what I'm missing, but I've given up. Essentially the system builds with a bunch of modules built, but the /lib/modules folder never gets installed. Additionally the Stretch installation nukes the rootfs/binary folder so you can't just run modules_install into there. What a faff. So, the modified mk-kernel script builds the kernel in deb-pkg mode, which produces a bunch of dpkg install files that get installed prior to the system image being created. This is also slightly cleaner. These packages are exported along with the system image, but the deb files are removed from the image to save space after installation.

## Customisation

This setup will build Debian Buster with some extra kernel options. It also builds a newer version of the kernel than is currently available on 96rocks or Vammrs. It's not quite mainline, but there are quite a few backported improvements by the looks of the repo. In the future the plan is to add mainline linux instead of the rockchip fork.

ssh-keygen is run pre-install so that you can ssh in right away. Docker-ce is also baked in.

The system hostname is set to the usual `linaro-alip` with the user `linaro`.

Extras are found in mk-rootfs-extra.sh, you can pre-install packages, add users, whatever you like in there. Just make sure you add stuff in the chroot section.

This is also a good place to try adding e.g. networking setup so that you can automatically connect to a known wifi hotspot on first boot.

## Notes

The first thing you should do after flashing this image is disable wlan power management. If you don't do this, SSH over the network will be incredibly slow. The instructions are [here](https://askubuntu.com/a/860754): 

Open `/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf` and change the contents to:

```
[connection]
wifi.powersave = 2
```

then run `sudo iwconfig`. You may need to run a cron job to fix this permanently otherwise it resets after a minute or so.

For example:

```
sudo crontab -e
```

and add:

```
* * * * * /sbin/iw wlan0 set power_save off
```
