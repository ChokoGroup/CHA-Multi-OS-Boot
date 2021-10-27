# ! /bin/sh
# For Choko Hack 12.0.0+

RUNNINGFROM="$(dirname "$(realpath "$0")")"

if [ -d "$RUNNINGFROM/CHA_BOOT" ] && [ "$(ls -A "$RUNNINGFROM/CHA_BOOT/")" ]
then
  mkdir -p /tmp/CHA_BOOT
  mount /dev/disk/by-label/CHA_BOOT /tmp/CHA_BOOT
  echo -e "\nUpdating files in partition CHA_BOOT:"
  cp -vr "$RUNNINGFROM/CHA_BOOT" /tmp/; WASOK=$?
  if [ $WASOK -eq 0 ]
  then
    echo -e "\e[1;32m\"CHA_BOOT\" was updated.\e[m"
  else
    echo -e "\e[1;31mThere was some error.\e[m"
    echo "Free space in partition CHA_BOOT: $(df -P /tmp/CHA_BOOT | tail -1 | awk '{print $4}')"
  fi
  umount /tmp/CHA_BOOT 2>/dev/null
else
	echo -e "\nFolder \"$RUNNINGFROM/CHA_BOOT\" not found or is empty."
fi

sleep 5
exit 202
