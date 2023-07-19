#!/bin/bash

#
# Banafshe Bamdad, Mo Jun 5, 2023 18:28:31
#
# This script runs the required commands in parallel in order to record ros bag file
# Usage: ./collect_data_RPG bag_file_name
#        e.g. $ ./collect_data_RPG my_test 
#

# check if the bag_file_name is passed to the script
if [ -z "$1" ]; then
  echo "Usage: ./collect_data_RPG.bash bag_file_name"
  exit 1
fi

file_name=$1


# -n 1: read only one character from the user's input
# -r: tells read to interpret backslashes literally, rather than treating them as escape characters.
# -s: hides the input while the user types
# -p $'...': specifies the prompt message. The $'...' syntax allows the use of escape sequences
read -n 1 -r -s -p $'Are you sure the camera is attached to the laptop? If so, press any key to continie, otherwise press the Ctrl-C, \n'

roslaunch realsense2_camera banafshe_RPG-S-2226_rs_camera.launch &
rosrun dynamic_reconfigure dynparam set /camera/stereo_module emitter_enabled 0
roslaunch kimera_vio_ros banafshe_kimera_vio_ros_RPG-S-0026.launch & 
rviz -d $(rospack find kimera_vio_ros)/rviz/kimera_vio_D435i.rviz & 
rosbag record -O "$file_name"_RPG_D435i.bag /camera/accel/imu_info  /camera/gyro/imu_info /camera/imu /camera/infra1/camera_info /camera/infra1/image_rect_raw /camera/infra2/camera_info /camera/infra2/image_rect_raw /camera/color/image_raw /camera/depth/image_rect_raw /camera/color/camera_info
