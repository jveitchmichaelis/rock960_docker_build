## Build a Rock960 debian image inside Docker

This Dockerfile provides a development environment to build system images for the Rock960 dev board. The instructions are broadly identical to: http://rageworx.ddns.net/index.php/easy-way-to-build-rock960-arm64-system-image/

To run, simply run `make_image.sh` which will:

1. Build the Docker container
2. Make a folder called `data` in the current folder
3. Run the container with the build script

Everything except deboostrap is run during the build phase, so currently kernel options are hardcoded into the Dockerfile.

The container must be launched in privileged mode, otherwise certain build operations will fail. The Dockerfile will build a desktop environment using the default settings, with overlayfs support. If you want a base image, then simply change the target to "base".

The system image will be copied to the `data` folder where you can flash it as usual:

```
sudo rkdeveloptool db rk3399_loader_v1.12.112.bin
sudo rkdeveloptool wl 0 data/system.img
sudo rkdeveloptool rd
```
