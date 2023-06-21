#!/bin/bash
SWAPFILE=/tmp/CHOKO_DISK/swapfile
if [ ! -f "$SWAPFILE" ]
then
  fallocate -l 512M $SWAPFILE
  chmod 600 $SWAPFILE
  mkswap $SWAPFILE
fi
swapon $SWAPFILE
