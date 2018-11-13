# We will use our base image that contains the OpenCV installation
FROM     joesan/raspi_opencv_3:latest
#FROM     jfloff/alpine-python
# We need Dropbox client SDK
RUN      pip install --upgrade dropbox
RUN      pip install "picamera[array]"
RUN      apt-get update
# Window Manager needs to be installed
RUN      sudo apt-get install lxde-core lxappearance
RUN      mkdir -p /raspi_motion_detection/project
WORKDIR  /raspi_motion_detection/project
COPY     ./ $WORKDIR/
COPY     ./requirements.txt $WORKDIR/
ADD      . $WORKDIR
#CMD      ["python", "core/motion_detector.py", "--conf", "conf/conf.json"]