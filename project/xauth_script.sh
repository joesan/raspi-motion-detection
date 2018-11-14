#!/bin/bash
CONTAINER_DISPLAY='0'
CONTAINER_HOSTNAME='cctv'
echo $DISPLAY
echo $(xauth list)
# Get the DISPLAY slot
DISPLAY_NUMBER=$(echo $DISPLAY | cut -d. -f1 | cut -d: -f2)
# Extract current authentication cookie
AUTH_COOKIE=$(xauth list | grep "^$(hostname)/unix:${DISPLAY_NUMBER} " | awk '{print $3}')
sudo su root
rm -Rf /root/.Xauthority
touch /root/.Xauthority
# Add the xauth cookie
xauth -f /root/.Xauthority add ${CONTAINER_HOSTNAME}/unix:${CONTAINER_DISPLAY} MIT-MAGIC-COOKIE-1 ${AUTH_COOKIE}
# Copy the xauth file to the root
cp /home/joesan/.Xauthority  /root/
chmod 777 /root/