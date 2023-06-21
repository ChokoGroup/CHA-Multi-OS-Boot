#/bin/sh
systemctl stop retroarch
mount -o remount,rw /flash
rm /flash/extlinux/extlinux.conf
mount -o remount,ro /flash
systemctl reboot
