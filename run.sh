#!/usr/bin/env sh

set -ex

# Install for QEMU emulation of arm
docker run --privileged --rm tonistiigi/binfmt --install all

docker run --rm --platform=linux/armhf alpine uname -a

# Verify architecture
docker run --rm -e QEMU_CPU=arm1176 --platform=linux/armhf alpine uname -a

mkdir builder

# Run the build script under an arm environment
docker run --rm -e QEMU_CPU=arm1176 --platform=linux/armhf \
	-v ${PWD}/build.sh:/app/build.sh \
	-v ${PWD}/builder:/home/builder \
	alpine sh /app/build.sh

mkdir release/
find builder/packages/ -name "*.apk" -type f -exec cp {} release/ \;
find builder/.abuild/ -name "*.pub" -type f -exec cp {} release/ \;
