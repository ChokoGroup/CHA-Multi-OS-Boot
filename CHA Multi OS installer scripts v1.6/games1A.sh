#!/bin/sh
# For Choko Hack 12.0.0+

RUNNINGFROM="$(dirname "$(realpath "$0")")"

mkdir -p /tmp/CHA_BOOT
mount /dev/disk/by-label/CHA_BOOT /tmp/CHA_BOOT
if [ -f /tmp/CHA_BOOT/sun8i-h3-orangepi-plus2e.dtb ] && [ -f /tmp/CHA_BOOT/KERNEL ] && [ -f /tmp/CHA_BOOT/SYSTEM ] && [ -e /dev/disk/by-label/LAKKA_DISK ]
then
  echo -e "\nInstalling Lakka files..."
  # Put files in FAT partition
  cp "$RUNNINGFROM/CHA_BOOT/oemsplash.png" /tmp/CHA_BOOT/
  mkdir -p /tmp/CHA_BOOT/extlinux
  cp "$RUNNINGFROM/CHA_BOOT/extlinux/extlinux.lakka.720p.conf" /tmp/CHA_BOOT/extlinux/

  # Put files in EXT4 partition
  mkdir -p /tmp/LAKKA_DISK
  mount /dev/disk/by-label/LAKKA_DISK /tmp/LAKKA_DISK

  cp -r "$RUNNINGFROM/LAKKA_DISK"/* /tmp/LAKKA_DISK/
  cp "$RUNNINGFROM/LAKKA_DISK/.profile" /tmp/LAKKA_DISK/
  mkdir -p /tmp/LAKKA_DISK/.config
  cp "$RUNNINGFROM/LAKKA_DISK/.config"/* /tmp/LAKKA_DISK/.config/
  chmod 755 /tmp/LAKKA_DISK/.config/*.sh
  chmod 755 /tmp/LAKKA_DISK/cores/*.so

  if [ -e /dev/disk/by-label/BATOCERA_DISK ]
  then
    mv "/tmp/LAKKA_DISK/playlists/_Reboot the CHA_ with Batocera.lpl" "/tmp/LAKKA_DISK/playlists/_Reboot the CHA_.lpl"
  else
    rm  "/tmp/LAKKA_DISK/playlists/_Reboot the CHA_ with Batocera.lpl"
  fi

  # Activate Lakka autostart script service to load our autostart.sh
  mkdir -p /tmp/LAKKA_DISK/.config/system.d/retroarch.service.wants
  ln -s /usr/lib/systemd/system/retroarch-autostart.service /tmp/LAKKA_DISK/.config/system.d/retroarch.service.wants/retroarch-autostart.service

  # Expand partition
  touch /tmp/LAKKA_DISK/.please_resize_me

  # Add Choko Menu option
  cp "$RUNNINGFROM/Run Lakka 720p."* /.choko/
  chmod 644 /.choko/*
  chmod 755 /.choko/*.sh
  umount /tmp/LAKKA_DISK 2>/dev/null
  echo -e "Lakka installed.\nThe first time booting into Lakka it will try to expand\nthe LAKKA_DISK partition and create missing folders/files."
else
  echo -e "\nLakka not installed:"
  [ -f /tmp/CHA_BOOT/sun8i-h3-orangepi-plus2e.dtb ] || echo "The file \"sun8i-h3-orangepi-plus2e.dtb\" is missing in partition CHA_BOOT."
  [ -f /tmp/CHA_BOOT/KERNEL ] || echo "The file \"KERNEL\" is missing in partition CHA_BOOT."
  [ -f /tmp/CHA_BOOT/SYSTEM ] || echo "The file \"SYSTEM\" is missing in partition CHA_BOOT."
  [ -e /dev/disk/by-label/LAKKA_DISK ] || echo "The partition \"LAKKA_DISK\" is missing."
fi
umount /tmp/CHA_BOOT 2>/dev/null

COUNTDOWN=10
while [ $COUNTDOWN -ge 0 ]
do
  echo -ne "\rShutting down in $COUNTDOWN seconds... "
  COUNTDOWN=$((COUNTDOWN - 1))
  sleep 1
done
echo -ne "\r\e[K"
exit 201
