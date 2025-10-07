set -ex 

export QEMU_CPU=arm1176 

uname -a

apk update && \
    apk add --no-cache alpine-sdk doas sed git

adduser -D builder && \
    addgroup builder abuild && \
    addgroup builder wheel && \
    echo 'permit nopass builder as root' > /etc/doas.d/doas.conf

su - builder -c sh << EOF
  set -x

  export QEMU_CPU=arm1176 
  uname -a
  
  abuild-keygen -a -n --install
  
  git clone --depth 1 -b 3.22-stable https://github.com/alpinelinux/aports /home/builder/aports
 
  # Disable strict devmem 
  cd /home/builder/aports/main/linux-rpi
  sed -i 's/\(CONFIG_STRICT_DEVMEM=\|CONFIG_IO_STRICT_DEVMEM=\).*/\1n/' common-changes.config
  abuild checksum
  
  abuild -crK
EOF
