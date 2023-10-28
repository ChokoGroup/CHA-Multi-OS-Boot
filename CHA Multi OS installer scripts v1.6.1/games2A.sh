#!/bin/sh
# For Choko Hack 12.0.0+

RUNNINGFROM="$(dirname "$(realpath "$0")")"

mkdir -p /tmp/CHA_BOOT
mount /dev/disk/by-label/CHA_BOOT /tmp/CHA_BOOT
if [ -f /tmp/CHA_BOOT/boot/batocera ] && [ -f /tmp/CHA_BOOT/boot/batocera.board ] && [ -f /tmp/CHA_BOOT/boot/capcom-home-arcade.dtb ] && [ -f /tmp/CHA_BOOT/boot/initrd.lz4 ] && [ -f /tmp/CHA_BOOT/boot/linux ] && [ -e /dev/disk/by-label/BATOCERA_DISK ]
then
  echo -e "\nInstalling Batocera files..."
  # Put files in FAT partition
  mkdir -p /tmp/CHA_BOOT/extlinux
  cp "$RUNNINGFROM/CHA_BOOT/extlinux/extlinux.batocera.720p.conf" /tmp/CHA_BOOT/extlinux/
  if [ -e /dev/disk/by-label/LAKKA_DISK ]
  then
    cp "$RUNNINGFROM/CHA_BOOT/boot/overlay.with.lakka" /tmp/CHA_BOOT/boot/overlay
  else
    cp "$RUNNINGFROM/CHA_BOOT/boot/overlay.without.lakka" /tmp/CHA_BOOT/boot/overlay
  fi
  cp "$RUNNINGFROM/CHA_BOOT/batocera-boot.conf" /tmp/CHA_BOOT/
  # Copy Choko Menu item
  cp "$RUNNINGFROM/Run Batocera 720p."* /.choko/
  chmod 644 /.choko/*
  chmod 755 /.choko/*.sh
  mkdir -p /tmp/BATOCERA_DISK
  mount /dev/disk/by-label/BATOCERA_DISK /tmp/BATOCERA_DISK
  cp -r "$RUNNINGFROM/BATOCERA_DISK" /tmp/
  chmod 755 /tmp/BATOCERA_DISK/system/custom.sh
  umount /tmp/BATOCERA_DISK 2>/dev/null
  echo -e "Batocera installed.\nThe first time booting into Batocera it will try to expand\nthe BATOCERA_DISK partition and create missing folders/files."
else
  echo -e "\nBatocera not installed:"
  [ -f /tmp/CHA_BOOT/boot/batocera ] || echo "The file \"/boot/batocera\" is missing in partition CHA_BOOT."
  [ -f /tmp/CHA_BOOT/boot/batocera.board ] || echo "The file \"/boot/batocera.board\" is missing in partition CHA_BOOT."
  [ -f /tmp/CHA_BOOT/boot/capcom-home-arcade.dtb ] || echo "The file \"/boot/capcom-home-arcade.dtb\" is missing in partition CHA_BOOT."
  [ -f /tmp/CHA_BOOT/boot/initrd.lz4 ] || echo "The file \"/boot/initrd.lz4\" is missing in partition CHA_BOOT."
  [ -f /tmp/CHA_BOOT/boot/linux ] || echo "The file \"/boot/linux\" is missing in partition CHA_BOOT."
  [ -e /dev/disk/by-label/BATOCERA_DISK ] || echo "The partition \"BATOCERA_DISK\" is missing."
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
