#!/bin/bash

HOST='cctv'
# Get the DISPLAY slot
DISPLAY_NUMBER=$(echo $DISPLAY | cut -d. -f1 | cut -d: -f2)
# Extract current authentication cookie
AUTH_COOKIE=$(xauth list | grep "^$(hostname)/unix:${DISPLAY_NUMBER} " | awk '{print $3}')
sudo su root
rm -Rf /root/.Xauthority
touch /root/.Xauthority
# Add the xauth cookie
xauth -fv /root/.Xauthority add ${HOST}/unix:${DISPLAY_NUMBER} MIT-MAGIC-COOKIE-1 ${AUTH_COOKIE}
# Copy the xauth file to the root
cp /home/joesan/.Xauthority  /root/
chmod 777 /root/
python /var/raspi_motion_detection/project/core/motion_detector.py --conf conf/conf.json