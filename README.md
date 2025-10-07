A script for builidng an Alpine linux kernel for Raspberry Pi Zero W with
`CONFIG_STRICT_DEVMEM=n` (disabled). This is needed for some libraries make use
of direct memory access.

This script makes use of Docker and QEMU to build the kernel on an x86 system. It specifically builds for the `armhf` architecture for the Raspberry Pi Zero W, but other ARM architectures should be similar.
It can then be transferred to the Raspberry Pi and installed.

## Instructions

 1. Invoke `./run.sh` on a system with docker installed. Wait approx 6h for a the build. Alternatively, use the kernel under `./release`.
 2. Copy the .pub key from `./release` to `/etc/apk/keys` on the the Pi
 3. Run `apk add linux-rpi-6.12.49-r0.apk` on the Pi and reboot.
