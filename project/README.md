## Building Docker Image

To build the Docker image for the motion detector Python scripts, do the following:

1. Change directors into the raspi-motion-detection/project directory and run the following command

  ```
  docker build -t joesan/motion_detector
  ```
  
  Choose your desired name for the image!
  
2. Once the build is successful, you can run it using the command:

  ```
  docker run -ti --device=/dev/vcsm \
    --device=/dev/vchiq \
    -e DISPLAY=$DISPLAY:0 \
    -e XAUTHORITY=/.Xauthority \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    joesan/motion_detector
    
  docker run -ti --device=/dev/vcsm \
    --device=/dev/vchiq \
    -e DISPLAY=$DISPLAY:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    joesan/motion_detector
    
  docker run -ti --device=/dev/vcsm \
    --device=/dev/vchiq \
    -e DISPLAY=$DISPLAY \
    joesan/motion_detector
  ``` 
  
You have to note that the Docker image for the motion detector python depends on another image which
contains all the needed OpenCV installed in it and optimised for working on the Raspberry Pi. Please have
a look [here](https://github.com/joesan/raspi-motion-detection/tree/master/infrastructure) for the OpenCV Dockerfile and [here](https://hub.docker.com/r/joesan/raspi_opencv_3/) for the image that you can just use out of the box

  docker run -ti --device=/dev/vcsm \
    --device=/dev/vchiq \
    -e DISPLAY=$DISPLAY \
    joesan/motion_detector
    
  sudo docker run --env DISPLAY=$DISPLAY --privileged --volume $XAUTH:/root/.Xauthority --volume /tmp/.X11-unix:/tmp/.X11-unix --rm -it joesan/motion_detector