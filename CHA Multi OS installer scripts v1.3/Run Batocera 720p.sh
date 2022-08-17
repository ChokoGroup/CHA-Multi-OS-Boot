#! /bin/sh
# For Choko Hack 12.0.0+

mkdir -p /tmp/CHA_BOOT
mount /dev/disk/by-label/CHA_BOOT /tmp/CHA_BOOT
cp /tmp/CHA_BOOT/extlinux/extlinux.batocera.720p.conf /tmp/CHA_BOOT/extlinux/extlinux.conf
sed -i -e "/.*es.resolution\=.*/{s//es.resolution=max-1280x720/;:a" -e '$!N;$!ba' -e '}' /tmp/CHA_BOOT/batocera-boot.conf
umount /tmp/CHA_BOOT 2>/dev/null

# Call for safe unmount and reboot
exit 200
