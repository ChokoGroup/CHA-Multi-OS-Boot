#!/bin/bash
SWAPFILE=/tmp/CHOKO_DISK/swapfile
if [ -e /dev/disk/by-label/CHOKO_DISK ] && [ ! -f "$SWAPFILE" ]
then
  fallocate -l 512M $SWAPFILE
  chmod 600 $SWAPFILE
  mkswap $SWAPFILE
fi
swapon $SWAPFILE
