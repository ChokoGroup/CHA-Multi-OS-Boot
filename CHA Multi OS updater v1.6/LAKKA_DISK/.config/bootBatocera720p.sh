#/bin/sh

systemctl stop retroarch
mount -o remount,rw /flash
cp /flash/extlinux/extlinux.batocera.720p.conf /flash/extlinux/extlinux.conf
sed -i -e "/.*es.resolution\=.*/{s//es.resolution=max-1280x720/;:a" -e '$!N;$!ba' -e '}' /flash/batocera-boot.conf
mount -o remount,ro /flash
systemctl reboot
