#! /bin/sh

if [ ! -e /storage/.please_resize_me ]
then
  {
  echo -en "\n\nFree space in LAKKA_DISK partition: "
  df -h /storage/ | tail -1 | awk '{print $4}'
  echo -e "\nTrying to expand LAKKA_DISK partition..."
  BOOTDISK=$(readlink -fn /dev/disk/by-label/LAKKA_DISK)
  parted ---pretend-input-tty ${BOOTDISK%p?} resizepart ${BOOTDISK#*p} yes 100%
  resize2fs /dev/disk/by-label/LAKKA_DISK
  echo -e "Done."
  echo -e "Free space: $(df -h /storage/ | tail -1 | awk '{print $4}')\n"
  COUNTDOWN=10
  while [ $COUNTDOWN -gt 0 ]
  do
    echo -ne "\rRebooting in $COUNTDOWN seconds... "
    COUNTDOWN=$((COUNTDOWN - 1))
    sleep 1
  done
  echo -e "\rRebooting!                         "
  mv /storage/.config/autostart_final.sh /storage/.config/autostart.sh; reboot
  } > /dev/tty0
fi
