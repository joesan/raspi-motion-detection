# We will use our base image that contains the OpenCV installation
FROM       joesan/raspi_opencv_3:latest
#FROM      jfloff/alpine-python
# We need Dropbox client SDK & picamera sdk
RUN        apt-get update
RUN        pip install --upgrade dropbox
RUN        pip install "picamera[array]"
# Install xauth for cookie and xserver display routing
RUN        sudo apt-get install xauth
# Prepare the target folders in the Docker container
RUN        mkdir -p /var/raspi_motion_detection/project
WORKDIR    /var/raspi_motion_detection/project
COPY       ./ $WORKDIR/
COPY       xauth_script.sh $WORKDIR/
#ADD        . $WORKDIR
# Perform xauth authentication for the xserver display routing
CMD [ "/bin/bash", "/var/raspi_motion_detection/project/run.bash"]
#CMD        ["python", "core/motion_detector.py", "--conf", "conf/conf.json"]