#!/bin/sh
# For Choko Hack 12.0.0+

RUNNINGFROM="$(dirname "$(realpath "$0")")"

rm -f "$RUNNINGFROM/CHA_BOOT/To update "* 2>/dev/null
if [ -d "$RUNNINGFROM/CHA_BOOT" ] && [ "$(ls -A "$RUNNINGFROM/CHA_BOOT/")" ]
then
  mkdir -p /tmp/CHA_BOOT
  mount /dev/disk/by-label/CHA_BOOT /tmp/CHA_BOOT
  CHABOOTUSED=$(du -c /tmp/CHA_BOOT/boot 2>/dev/null | tail -n 1 | awk '{print $1;}')
  CHABOOTFREE=$(df -P /tmp/CHA_BOOT/ | tail -1 | awk '{print $4}')
  CHABOOTAVAILABLE=$((CHABOOTUSED + CHABOOTFREE))
  USBBOOTUSED=$(du -c "$RUNNINGFROM/CHA_BOOT" "$RUNNINGFROM/overlay.with.lakka" 2>/dev/null | tail -n 1 | awk '{print $1;}')
  echo -e "\nSpace available in partition CHA_BOOT: $CHABOOTAVAILABLE\nSpace needed: $USBBOOTUSED"
  if [ $((USBBOOTUSED)) -gt $((CHABOOTAVAILABLE)) ]
  then
    echo -e "\n\e[1;31mNot enought space to upgrade in partition CHA_BOOT.\e[m"
    COUNTDOWN=10
  else
    echo -e "\nUpdating files in partition CHA_BOOT:"
    WASOK=0
    # Make 'for' loops use entire lines
    OIFS="$IFS"
    IFS=$'\n'
    # Mount assets to change UI if they exist
    for FILESTOUPDATE in $(find "$RUNNINGFROM/CHA_BOOT" -name '*' -type f -print 2> /dev/null)
    do
      if [ $WASOK -eq 0 ]
      then
        TARGETFILE="/tmp/CHA_BOOT/${FILESTOUPDATE#*'/CHA_BOOT/'}"
        [ -f "$TARGETFILE" ] && rm -v "$TARGETFILE"
        cp -v "$FILESTOUPDATE" "$TARGETFILE"; WASOK=$?
      fi
    done
    IFS="$OIFS"
    if [ $WASOK -eq 0 ]
    then
      echo -e "\e[1;32m\"CHA_BOOT\" was updated.\e[m"
      mkdir -p /tmp/CHA_DISK
      mount /dev/disk/by-label/CHA_DISK /tmp/CHA_DISK
      find "/tmp/CHA_DISK/.choko" -type f \( -name "Run Lakka 1080p*" -or -name "Run Batocera 1080p*" \) -exec rm {} +
      if [ -e /dev/disk/by-label/LAKKA_DISK ]
      then
        cp -v "$RUNNINGFROM/extlinux.lakka.720p.conf" /tmp/CHA_BOOT/extlinux/
        mkdir -p /tmp/LAKKA_DISK
        mount /dev/disk/by-label/LAKKA_DISK /tmp/LAKKA_DISK
        cp -v "$RUNNINGFROM/LAKKA_DISK/.config/autostart.sh" /tmp/LAKKA_DISK/.config/
        chmod 755 /tmp/LAKKA_DISK/.config/autostart.sh
        cp -v "$RUNNINGFROM/LAKKA_DISK/.config/swap.conf.choko" /tmp/LAKKA_DISK/.config/
        [ -f /tmp/LAKKA_DISK/.config/bootBatocera720p.sh ] && cp -v "$RUNNINGFROM/LAKKA_DISK/.config/bootBatocera720p.sh" /tmp/LAKKA_DISK/.config/
        [ -f /tmp/LAKKA_DISK/.config/bootBatocera1080p.sh ] && rm -v /tmp/LAKKA_DISK/.config/bootBatocera1080p*
      fi
      if [ -e /dev/disk/by-label/BATOCERA_DISK ]
      then
        cp -v "$RUNNINGFROM/extlinux.batocera.720p.conf" /tmp/CHA_BOOT/extlinux/
        if [ -e /dev/disk/by-label/LAKKA_DISK ]
        then
          cp "$RUNNINGFROM/overlay.with.lakka" /tmp/CHA_BOOT/boot/overlay
        else
          cp "$RUNNINGFROM/overlay.without.lakka" /tmp/CHA_BOOT/boot/overlay
        fi
        mkdir -p /tmp/BATOCERA_DISK
        mount /dev/disk/by-label/BATOCERA_DISK /tmp/BATOCERA_DISK
        cp -r "$RUNNINGFROM/BATOCERA_DISK" /tmp/
        chmod 755 /tmp/BATOCERA_DISK/system/custom.sh
        [ -f /tmp/BATOCERA_DISK/system/configs/emulationstation/es_systems_fbalpha2012.cfg ] && rm -v /tmp/BATOCERA_DISK/system/configs/emulationstation/es_systems_fbalpha2012.cfg
        [ -f /tmp/BATOCERA_DISK/system/configs/emulationstation/es_systems_mame2010.cfg ] && rm -v /tmp/BATOCERA_DISK/system/configs/emulationstation/es_systems_mame2010.cfg
      fi
      umount /tmp/CHA_DISK 2>/dev/null
      umount /tmp/LAKKA_DISK 2>/dev/null
      umount /tmp/BATOCERA_DISK 2>/dev/null
      echo -e "\e[1;32mDone.\e[m\n"
      # To reboot:
      # exit 200 
      # To power off:
      exit 201
    else
      echo -e "\e[1;31mThere was some error.\e[m"
      echo "Free space in partition CHA_BOOT: $(df -P /tmp/CHA_BOOT | tail -1 | awk '{print $4}')"
      echo -e "\n\e[1;31mFolder \"$RUNNINGFROM/CHA_BOOT\" not found or is empty.\e[m"
      COUNTDOWN=15
    fi
  fi
  umount /tmp/CHA_BOOT 2>/dev/null
else
	echo -e "\n\e[1;31mFolder \"$RUNNINGFROM/CHA_BOOT\" not found or is empty.\e[m"
  COUNTDOWN=5
fi

while [ $COUNTDOWN -ge 0 ]
do
  echo -ne "\rReturning to Choko Menu in $COUNTDOWN seconds... "
  COUNTDOWN=$((COUNTDOWN - 1))
  sleep 1
done
exit 202  # Return to Choko Menu
