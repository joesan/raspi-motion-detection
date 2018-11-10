FROM python:3.7
MAINTAINER Joesan <http://www.inland24.com>

# Hack to install libjasper-dev from older Ubuntu sources
# https://stackoverflow.com/questions/43484357/opencv-in-ubuntu-17-04/44488374#44488374
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ yakkety universe" | sudo tee -a /etc/apt/sources.list

# Install dependencies needed for building and running OpenCV
RUN apt-get update && apt-get install -y --no-install-recommends \
    # to build and install
    unzip \
    build-essential cmake pkg-config \
    # to work with images
    libjpeg-dev libtiff-dev libjasper-dev libpng-dev \
    # to work with videos
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev \
    # needed by highgui tool
    libgtk2.0-dev \
    # for opencv math operations
    libatlas-base-dev gfortran \
    # others
    libtbb2 libtbb-dev \
    # cleanup
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -y autoremove

# OpenCV requires numpy
RUN pip install --no-cache-dir numpy

# Virtual environment for OpenCV
RUN pip install virtualenv && \
         virtualenvwrapper

# virtualenv and virtualenvwrapper
RUN export WORKON_HOME=$HOME/.virtualenvs
RUN source /usr/local/bin/virtualenvwrapper.sh

# update .profile
RUN echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.profile
RUN echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.profile
RUN echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.profile
RUN source ~/.profile

# Create the virtual environment
RUN mkvirtualenv cv -p python3
RUN workon cv

# OpenCV download, compilation and installation
WORKDIR /
ENV OPENCV_VERSION="3.4.2"
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \
&& mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
&& cd /opencv-${OPENCV_VERSION}/cmake_binary \
&& cmake -DBUILD_TIFF=ON \
  -DBUILD_opencv_java=OFF \
  -DWITH_CUDA=OFF \
  -DWITH_OPENGL=ON \
  -DWITH_OPENCL=ON \
  -DWITH_IPP=ON \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DBUILD_TESTS=OFF \
  -DBUILD_PERF_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=$(python3.7 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.7) \
  -DPYTHON_INCLUDE_DIR=$(python3.7 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
  -DPYTHON_PACKAGES_PATH=$(python3.7 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
  .. \
&& make install \
&& rm /${OPENCV_VERSION}.zip \
