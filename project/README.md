## Building Docker Image

To build the Docker image for the motion detector Python scripts, do the following:

1. Change directors into the raspi-motion-detection/project directory and run the following command

  ```
  docker build -t joesan/motion_detector .
  ```
  
  Choose your desired name for the image! You do not have to build it by your own. I have an image that you can download from here: 
  
   ```
  docker pull joesan/raspi_opencv_3:latest
   ```
  
2. Once the build is successful, you can run it using the command:

  ```
  docker run -it --net=host \
    --device=/dev/vcsm \
    --device=/dev/vchiq \
    --volume="/home/joesan/.Xauthority:/root/.Xauthority:rw" \
    -e DISPLAY \
    -v /tmp/.X11-unix \
    joesan/motion_detector
  ``` 
  
  A few things to note here:
  
  * To access the Raspberry Pi Camera you need to allow access to the vcsm and vchiq devices which is what you do with the --     devices option from the command above
  
  * You need to have a proper xauth file and attach it to the root which is what you do with the --volume option
    from the command above (Have a look in the motion_detector.bash to find out how we create the .Xauthority file based on       the DISPLAY parameter)    
  
You have to note that the Docker image for the motion detector python depends on another image which
contains all the needed OpenCV installed in it and optimised for working on the Raspberry Pi. Please have
a look [here](https://github.com/joesan/raspi-motion-detection/tree/master/infrastructure) for the OpenCV Dockerfile 
and [here](https://hub.docker.com/r/joesan/raspi_opencv_3/) for the image that you can just use out of the box!

Finally saying thanks to [pyimagesearch](https://www.pyimagesearch.com) for the excellent tutorial and the majorirty of the Python scripts!
