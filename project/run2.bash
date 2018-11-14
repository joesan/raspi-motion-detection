#!/bin/bash

HOST=cctv
DISPLAY_NUMBER=$(echo $DISPLAY | cut -d. -f1 | cut -d: -f2)
AUTH_COOKIE=$(xauth list | grep "^$(hostname)/unix:${DISPLAY_NUMBER} " | awk '{print $3}')
xauth add ${HOST}/unix:${DISPLAY_NUMBER} MIT-MAGIC-COOKIE-1 ${AUTH_COOKIE}
python /opvart/raspi_motion_detection/project/core/motion_detector.py --conf conf/conf.json