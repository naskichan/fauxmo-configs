#!/bin/bash
UUID=5C6A-F933
#UUID=76DC18D9DC189609
VAR=$(lsblk -f | grep -c $UUID)
if [ $VAR==1 ]; then
umount UUID=$UUID
echo Username: "$USER EUID: $EUID" > /home/naski/temp
mount.ntfs UUID=$UUID /mnt/Intenso
fi
