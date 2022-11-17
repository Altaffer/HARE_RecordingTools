#!/bin/bash

echo $#

# the place to save pids for killing 
# FILE=pids.txt
# saving the data to a text file
FILE=fdata.txt

# restart nvargus to make it extra happy
sudo systemctl restart nvargus-daemon


# roscore & echo $! >> $FILE
# clear  pids
# rm pids.txt; touch pids.txt
rm $FILE; touch $FILE


# roscore
roscore & echo $! >> $FILE
sleep 10
# launch the cameras to background and save the pid to pids.txt
roslaunch ~/catkin_ws/src/img_pipeline/launch/nv12_test.launch & echo $! >> $FILE
# launching the vehicle node to the background and save data to the flight data file 
roslaunch ~/catkin_ws/src/Onboard-SDK-ROS/launch/dji_vehicle_node.launch & echo $! >> $FILE
# launch the gps node
roslaunch ~/catkin_ws/src/ros_zedf9p/ublox_gps/launch/hare_gps.launch & echo $! >> $FILE
# launch micasense node
python3 ~/catkin_ws/src/micasense/scripts/main_v2.py & echo $! >> $FILE
#python3 ~/catkin_ws/src/micasense/src/viz.py & echo $! >> $FILE

# launch imu
# rosrun rosserial_arduino serial_node.py _port:=/dev/ttyACM0 _baud:=115200 & echo $! >> $FILE

# launch the rosbag to background and save the pid to pids.txt
#rosbag record /cam0/camera/image_raw /cam1/camera/image_raw /therm/image_raw_throttle /imu & echo $! >> $FILE

#rosbag record -o /media/jetson/hareflightdisk00/ /cam0/camera/image_raw /cam1/camera/image_raw /therm/image_raw_throttle /dji_osdk_ros/attitude /dji_osdk_ros/battery_state /dji_osdk_ros/flight_status /dji_osdk_ros/height_above_takeoff /dji_osdk_ros/imu /dji_osdk_ros/gps_position /dji_osdk_ros/local_position /dji_osdk_ros/rc /dji_osdk_ros/rc_connection_status /dji_osdk_ros/velocity /ublox/fix /micasense_viz & echo $! >> $FILE
# if [[$# == 0 ]]; then
#rosbag record $(cat djiRosTopics.json | jq -r '.active_topics | .[]') -o /media/jetson/hareflightdisk00/ /cam0/camera/image_raw /cam1/camera/image_raw /therm/image_raw_throttle /ublox/fix /micasense_viz & echo $! >> $FILE
#fi
