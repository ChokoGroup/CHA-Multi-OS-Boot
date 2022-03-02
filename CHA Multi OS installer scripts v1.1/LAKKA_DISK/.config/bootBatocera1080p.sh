#/bin/sh

systemctl stop retroarch
mount -o remount,rw /flash
cp /flash/extlinux/extlinux.batocera.1080p.conf /flash/extlinux/extlinux.conf
mount -o remount,ro /flash
systemctl reboot
