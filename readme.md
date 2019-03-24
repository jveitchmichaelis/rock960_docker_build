## Build a Rock960 debian image inside Docker

This Dockerfile provides a development environment to build system images for the Rock960 dev board.

To run, simply run make_image.sh which will:

1. Build the Docker container
2. Make a folder called "data" in the current folder
3. Run the container with the build script

The container must be launched in privileged mode, otherwise certain build operations will fail. The Dockerfile will build a desktop environment using the default settings, with overlayfs support. If you want a base image, then simply change the target to "base".
