## Build Docker image for OpenCV and Raspberry Pi

You probably do not want to build this by yourself! It is very time consuming! But if you insist, you can do so! Just 
follow along!

A few things to note before you proceed with the build:

1. A minimum of 16GB or more SD card is needed. I would however recommend to use a 32 GB SD card.

2. Increase the swap size on your Pi. To do this edit the /etc/dphys-swapfile file and set the ```CONF_SWAPFACTOR=1``` and ```CONF_MAXSWAP=2048```. Without this the RasPi will run our of RAM space and your Docker build will 
freeze when it is around 86%
   
3. We will build our Docker image for the Raspbian Stretch OS

4. In the Dockerfile when we run the make command to build OpenCV source files, make sure to have the number of
   cores set to 1. For example., in the Dockerfile (line number 68), I have it set to a single core ```&& make -j1```. If you    would like to try it with more cores (say 4), you can set it as ```&& make -j4``` but with j4 as an option, my build          stopped after it reached 86%. So leave it at 1!

To build the image yourself on your Pi, do the following:

1. First clone the repo on your Raspberry Pi
   
   ```
   git clone https://github.com/joesan/raspi-motion-detection.git
   ```

2. Next, cd into the cloned repo and run docker build. On my Raspberry Pi, it is as shown below!
   
   ```
   joesan@cctv:~/projects/raspi-motion-detection $ docker build -t joesan/raspi_opencv_3 .
   ```
   
   If you have any other activities planned, just go ahead and complete them as the command above is going to take
   at least a minimum of 3 hours to complete!
   
3. Once complete, you can check for the image using the docker images command. Here is what I have on my Pi!
   
   ```
   joesan@cctv:~/projects/raspi-motion-detection $ docker images
   REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
   joesan/raspi_opencv_3   latest              1c8720385ec7        2 hours ago         916MB
   resin/rpi-raspbian      stretch             21dc8fc1377f        2 weeks ago         139MB
   ```
   
4. To test if your image is working properly, issue the following command to run the image! Here we are just going to
   print the OpenCV version
   
   ```
   joesan@cctv:~/projects/raspi-motion-detection $ docker run -it joesan/raspi_opencv_3 python -c "import cv2; print(cv2.__version__)"
   3.3.1
   ``` 

Like I said earlier, building OpenCV is a lengthy process and requires shit loads of time. I have already done this and if you are just interested in getting a pre-built image that is guaranteed to work, then you can download it from [here](https://hub.docker.com/r/joesan/raspi_opencv_3/)

Ok, so you now have the OpenCV image, then proceed to runnning the actual project over [here](https://github.com/joesan/raspi-motion-detection/tree/master/project)
