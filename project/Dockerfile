# We will use our base image that contains the OpenCV installation
FROM       joesan/raspi_opencv_3:latest
#FROM      jfloff/alpine-python
# We need Dropbox client SDK & picamera sdk
RUN        apt-get update
RUN        pip install --upgrade dropbox
RUN        pip install "picamera[array]"
# Install xauth for cookie and xserver display routing
RUN        sudo apt-get install xauth
RUN        mkdir -p /raspi_motion_detection/project
WORKDIR    /raspi_motion_detection/project
COPY       ./ $WORKDIR/
COPY       xauth_script.sh $WORKDIR/
ADD        . $WORKDIR
RUN        CD $WORKDIR
# Perform xauth authentication for the xserver display routing
ENTRYPOINT [ "/bin/bash", "xauth_script.sh"]
CMD        ["python", "core/motion_detector.py", "--conf", "conf/conf.json"]