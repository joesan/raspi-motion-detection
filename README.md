
### Setting up your Raspberry Pi (Assume Pi 3 Model B+)

Saying thanks to [pyimagesearch](https://www.pyimagesearch.com) for the excellent tutorial and the majorirty of the Python scripts!

This is the very first step as you need to prepare the SD card
with the raspberry operating system. We wil use [Etcher](https://www.balena.io/etcher/https://www.balena.io/etcher/)
for this purpose. Just download Etcher for your operating system and follow
the steps below:

1. Format the SD card! You should know how to do this!
2. Head on to the Raspberry website and download the latest version
   of the OS! You might want to consider the headless version to save some
   space and memory when running on your RasPi
3. Open Etcher and just flash the SD card with the Raspberry OS that you
   just downloaded
4. Insert the SD card on to your RasPi and it is now time to boot it up!
5. You now have to set up the WiFi password (Assuming that you are using Pi 3 Model B+ which
has a built in WiFi module). Do the following:
   
   Type the following in the command line:
   
   ```
   sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
   ```
   
   Now, just add the following to the conf file. Refer your router for the ssid and psk details!
   
   ```
   network={
        ssid="The_ESSID_from_earlier"
        psk="Your_wifi_password"
   }
   ```
6. I normally prefer to change the default user and password to something to my liking! You can skip
this step if you wish to work with the defaults! If in case, you wish to change the default user and password
do the following steps:

   Enable root login by giving the following command
    ```
    sudo passwd root
    ```
   Logout of the pi user
    ```
    logout
    ```
   Now Login back in as the user 'root' using the password you just created. Now we can change the default user
    for the raspberry pi using the following command
    ```
    usermod -l newusername pi
    ```
   Now we have to also change the user's default home directory to reflect this new user! The command below should do that
   ```
   usermod -m -d /home/newusername newusername
   ```
   Logout and Login again with this new user and change the password for this new user! That's it!
    
### Set up Docker in Raspberry Pi

Since all installations (Python, OpenCV) here are encapsulated in a Dockerfile,
we need to install Docker!

Installing Docker in Raspberry Pi is pretty simple. Just open a terminal
and run the following command:

```
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
```

Optionally to run Docker without sudo, do the following:

1. Add a Docker group if it does not exist

```
sudo groupadd docker
```

2. Add the connected $USER to the docker group where $USER could be th 
current user

```
sudo gpasswd -a $USER docker
```

3. Run newgrp command so that the changes take effect

```
newgrp docker
```

4. Check if it worked

```
docker run hello-world
```

If it worked, you should see "Hello from Docker" printed out!

### Installing Python and OpenCV

This step is fairly simple as you just have to build or run a Docker image! Yes, you have two choices here!

Either pull and run the docker image that is already created or use the source Dockerfile and build the image for yourself!
You have to know that building the image with OpenCV is not a task that is done within minutes. On my Raspberry Pi Model 3 B+, it
took me about 3 hours to fully build the image. So if you are looking for a quicker install, just grab the docker image 
from my docker hub repo from [here](https://hub.docker.com/r/joesan/raspi_opencv_3/)

TODO: Documentation.... you probably need to first have the following components with you!

1. A Raspberry Pi - I prefer to use the Model 3 B+ that has a built in WiFi

2. A Pi Camera - I got the Raspberry Pi v2.1, 8 MP NoIR camera as this one can take pictures in the dark
provided it has an IR filters

3. A proper case to protect the Pi and the camera. If you are going to mount the setup outdoors, you might
want to consider the following:

   3.1 How are you going to get WiFi coverage at the outdoor location
   3.2 How are you going to get the Power supply to the Pi
   3.3 Would the case tolerate harsh weather conditions
 
Once everything is assembled, check if the camera is working using the following command on your Pi

    ```
    raspistill -o output.jpg
    ```

Ok! So if you are thus far here, then proceed to building your OpenCV Docker image. Have a look [here](https://github.com/joesan/raspi-motion-detection/tree/master/infrastructure)

