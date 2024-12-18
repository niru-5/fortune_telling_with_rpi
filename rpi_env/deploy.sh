#!/bin/bash

# take param which rpi to use
rpi_ip=$1

# copy the files to rpi
scp -r rpi_env/* $rpi_ip:~/Documents/rpi_env/
# run the script
ssh $rpi_ip "export DISPLAY=:0 &&
        cd ~/Documents/rpi_env && 
        python3 picamera_image_collection.py --config picam_config.json"

# copy the images back to the host machine
scp -r $rpi_ip:~/Documents/rpi_env/images ./data/rpi_data/

