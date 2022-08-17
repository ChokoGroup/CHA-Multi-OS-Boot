#! /bin/sh
# For Choko Hack 12.0.0+

mkdir -p /tmp/CHA_BOOT
mount /dev/disk/by-label/CHA_BOOT /tmp/CHA_BOOT
cp /tmp/CHA_BOOT/extlinux/extlinux.lakka.1080p.conf /tmp/CHA_BOOT/extlinux/extlinux.conf
umount /tmp/CHA_BOOT 2>/dev/null

# Call for safe unmount and reboot
exit 200
