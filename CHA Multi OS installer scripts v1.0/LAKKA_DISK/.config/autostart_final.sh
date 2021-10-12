#!/bin/sh

#wifi seems to not start automatically so I added this
connmanctl enable wifi
connmanctl scan wifi

if [ -e /dev/disk/by-label/CHOKO_DISK ]
then
  mkdir -p /tmp/CHOKO_DISK
  mount /dev/disk/by-label/CHOKO_DISK /tmp/CHOKO_DISK
  mkdir -p /tmp/CHOKO_DISK/roms
  umount /storage/roms/* >/dev/null
  mount --bind /tmp/CHOKO_DISK/roms /storage/roms
  if [ ! -f "/tmp/CHOKO_DISK/playlists/_Reboot the CHA_.lpl" ]
  then
    mkdir -p /tmp/CHOKO_DISK/playlists
    cp "/storage/playlists/_Reboot the CHA_.lpl" /tmp/CHOKO_DISK/playlists/
  fi
  mount --bind /tmp/CHOKO_DISK/playlists /storage/playlists
  if [ ! -d "/tmp/CHOKO_DISK/thumbnails/_Reboot the CHA_" ]
  then
    mkdir -p /tmp/CHOKO_DISK/thumbnails
    cp -r "/storage/thumbnails/_Reboot the CHA_" /tmp/CHOKO_DISK/thumbnails/
  fi
  mount --bind /tmp/CHOKO_DISK/thumbnails /storage/thumbnails
  if [ ! -f "/tmp/CHOKO_DISK/assets/xmb/monochrome/png/_Reboot the CHA_.png" ]
  then
    cp -r /storage/assets /tmp/CHOKO_DISK/
  else
    cp -r /tmp/CHOKO_DISK/assets /storage/
  fi
  if [ ! -d /tmp/CHOKO_DISK/overlays ]
  then
    cp -r /tmp/overlays /tmp/CHOKO_DISK/
  fi
  systemctl stop tmp-overlays.mount
  mount --bind /tmp/CHOKO_DISK/overlays /storage/overlays
  mkdir -p /tmp/CHOKO_DISK/remappings
  mount --bind /tmp/CHOKO_DISK/remappings /storage/remappings
  mkdir -p  /tmp/CHOKO_DISK/.config/retroarch/config
  mount --bind /tmp/CHOKO_DISK/.config/retroarch/config /storage/.config/retroarch/config
  if [ ! -d /tmp/CHOKO_DISK/cores ]
  then
    cp -r /storage/cores /tmp/CHOKO_DISK/
  else
    cd /tmp/CHOKO_DISK/cores
    for f in $(ls *.info)
    do
      cp -u "/tmp/CHOKO_DISK/cores/$f" "/storage/cores/$f"
      chmod 644 "/storage/cores/$f"
    done
    for f in $(ls *.so)
    do
      cp -u "/tmp/CHOKO_DISK/cores/$f" "/storage/cores/$f"
      chmod 755 "/storage/cores/$f"
    done
  fi
fi
