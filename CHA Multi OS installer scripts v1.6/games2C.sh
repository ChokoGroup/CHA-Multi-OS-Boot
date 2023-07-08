#!/bin/sh
# For Choko Hack 12.0.0+

# Simple string compare, since until 10.0.0 CHOKOVERSION wasn't set
# Future versions need to keep this in mind
if [ "$CHOKOVERSION" \< "12.0.0" ]
then
  echo -e "\nYou are running an outdated version of Choko Hack.\nYou need v12.0.0 or later.\n";
  COUNTDOWN=5
  while [ $COUNTDOWN -ge 0 ]
  do
    echo -ne "\rRebooting in $COUNTDOWN seconds... "
    COUNTDOWN=$((COUNTDOWN - 1))
    sleep 1
  done
  echo -ne "\r\e[K"
  if [ "$CHOKOVERSION" \< "10.0.0" ]
  then
    reboot -f
  else
    exit 200
  fi
fi

if [ -e /dev/disk/by-label/BATOCERA_DISK ]
then
  echo -e "\n\n"
  WAITING="Y"
  SELECTEDOPTION="Cancel"
  until [ "$WAITING" = "N" ]
  do
    echo -ne "\r\e[1;93mPlease confirm that you want to delete Batocera files and format BATOCERA_DISK:\e[m $SELECTEDOPTION "
    case "$(readjoysticks j1)" in
      U|D|R|L)
        if [ "$SELECTEDOPTION" = "Cancel" ]
        then
          SELECTEDOPTION="Delete"
        else
          SELECTEDOPTION="Cancel"
        fi
      ;;
      0|1|2|3|4|5|6|7)
        WAITING="N"
        echo -e "\n"
        if [ "$SELECTEDOPTION" = "Delete" ]
        then
          mkdir -p /tmp/CHA_BOOT
          mount /dev/disk/by-label/CHA_BOOT /tmp/CHA_BOOT
          rm -rf /tmp/CHA_BOOT/boot
          rm /tmp/CHA_BOOT/extlinux/extlinux.batocera*
          rm /tmp/CHA_BOOT/batocera-boot.conf
          umount /tmp/CHA_BOOT 2>/dev/null
          mkfs -v -t ext4 /dev/disk/by-label/BATOCERA_DISK
        fi
      ;;
    esac
  done
  rm "/.choko/Run Batocera"*
  echo "Batocera completely uninstalled (system files deleted and partition formated)."
else
  echo "\"BATOCERA_DISK\" partition not found."
fi
sleep 3
# Go back to Choko Menu
exit 202
