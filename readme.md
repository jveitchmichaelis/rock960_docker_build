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
