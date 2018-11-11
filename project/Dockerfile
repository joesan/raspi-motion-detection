# We will use our base image that contains the OpenCV installation
FROM joesan/raspi_opencv_3:latest
RUN  mkdir project
COPY project/* project/
CMD ["python", "__init__.py"]