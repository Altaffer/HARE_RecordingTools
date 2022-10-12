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
# roslaunch ~/catkin_ws/src/Onboard-SDK-ROS/launch/dji_vehicle_node.launch & echo $! >> $FILE
# launch the gps node
roslaunch ~/catkin_ws/src/ros_zedf9p/ublox_gps/launch/hare_gps.launch & echo $! >> $FILE
# launch micasense node
python3 ~/catkin_ws/src/micasense/scripts/main.py & echo $! >> $FILE


# launch imu
# rosrun rosserial_arduino serial_node.py _port:=/dev/ttyACM0 _baud:=115200 & echo $! >> $FILE

# launch the rosbag to background and save the pid to pids.txt
#rosbag record /cam0/camera/image_raw /cam1/camera/image_raw /therm/image_raw_throttle /imu & echo $! >> $FILE

#rosbag record -o /media/jetson/hareflightdisk00/ /cam0/camera/image_raw /cam1/camera/image_raw /therm/image_raw_throttle /dji_osdk_ros/attitude /dji_osdk_ros/battery_state /dji_osdk_ros/flight_status /dji_osdk_ros/height_above_takeoff /dji_osdk_ros/imu /dji_osdk_ros/gps_position /dji_osdk_ros/local_position /dji_osdk_ros/rc /dji_osdk_ros/rc_connection_status /dji_osdk_ros/velocity /ublox/fix & echo $! >> $FILE
# if [[$# == 0 ]]; then
rosbag record $(cat djiRosTopics.json | jq -r '.active_topics | .[]') -o /media/jetson/hareflightdisk001/ /cam0/camera/image_raw /cam1/camera/image_raw /therm/image_raw_throttle /ublox/fix /micasense_data & echo $! >> $FILE
#fi

# dji topics
# acceleration ground fused
#rosbag record /dji_osdk_ros/acceleration_ground_fused & echo $! >> $FILE
# angular velocity 
#rosbag record /dji_osdk_ros/angular_velocity & echo $! >> $FILE
# attitude
#rosbag record /dji_osdk_ros/attitude & echo $! >> $FILE
# battery state
#rosbag record /dji_osdk_ros/battery_state & echo $! >> $FILE
# camera h264 stream
#rosbag record /dji_osdk_ros/camera_h264_stream & echo $! >> $FILE
# display mode
#rosbag record /dji_osdk_ros/display_mode & echo $! >> $FILE
# flight anomaly
#rosbag record /dji_osdk_ros/flight_anomaly & echo $! >> $FILE
# flight status
#rosbag record /dji_osdk_ros/flight_status & echo $! >> $FILE
# fpv camera images
#rosbag record /dji_osdk_ros/fpv_camera_images & echo $! >> $FILE
# from mobile data
#rosbag record /dji_osdk_ros/from_mobile_data & echo $! >> $FILE
# from payload data
#rosbag record /dji_osdk_ros/from_payload_data & echo $! >> $FILE
# gimbal data
#rosbag record /dji_osdk_ros/gimbal_data & echo $! >> $FILE
# gps health
#rosbag record /dji_osdk_ros/gps_health & echo $! >> $FILE
# gps postion
#rosbag record /dji_osdk_ros/gps_position & echo $! >> $FILE
# height above takeoff
#rosbag record /dji_osdk_ros/height_above_takeoff & echo $! >> $FILE
# imu
#rosbag record /dji_osdk_ros/imu & echo $! >> $FILE
# local_frame_ref
#rosbag record /dji_osdk_ros/local_frame_ref & echo $! >> $FILE
# local_position
#rosbag record /dji_osdk_ros/local_position & echo $! >> $FILE
# main_camera_images
#rosbag record /dji_osdk_ros/main_camera_images & echo $! >> $FILE
# rc
#rosbag record /dji_osdk_ros/rc & echo $! >> $FILE
# rc_connection_status
#rosbag record /dji_osdk_ros/rc_connection_status & echo $! >> $FILE
# rtk_connection_status
#rosbag record /dji_osdk_ros/rtk_connection_status & echo $! >> $FILE
# rtk_info_position
#rosbag record /dji_osdk_ros/rtk_info_position & echo $! >> $FILE
# rtk_info_yaw
#rosbag record /dji_osdk_ros/rtk_info_yaw & echo $! >> $FILE
# rtk_position
#rosbag record /dji_osdk_ros/rtk_position & echo $! >> $FILE
# rtk_velocity
#rosbag record /dji_osdk_ros/rtk_velocity & echo $! >> $FILE
# rtk_yaw
#rosbag record /dji_osdk_ros/rtk_yaw & echo $! >> $FILE
# stereo_240p_down_back_images
#rosbag record /dji_osdk_ros/stereo_240p_down_back_images & echo $! >> $FILE
# stereo_240p_down_front_images
#rosbag record /dji_osdk_ros/stereo_240p_down_front_images & echo $! >> $FILE
# stereo_240p_front_depth_images
#rosbag record /dji_osdk_ros/stereo_240p_front_depth_images & echo $! >> $FILE
# stereo_240p_front_left_images
#rosbag record /dji_osdk_ros/stereo_240p_front_left_images & echo $! >> $FILE
# stereo_240p_front_right_images
#rosbag record /dji_osdk_ros/stereo_240p_front_right_images & echo $! >> $FILE
# stereo_vga_front_left_images
#rosbag record /dji_osdk_ros/stereo_vga_front_left_images & echo $! >> $FILE
# stereo_vga_front_right_images
#rosbag record /dji_osdk_ros/stereo_vga_front_right_images & echo $! >> $FILE
# time_sync_fc_time_utc
#rosbag record /dji_osdk_ros/time_sync_fc_time_utc & echo $! >> $FILE
# time_sync_gps_utc
#rosbag record /dji_osdk_ros/time_sync_gps_utc & echo $! >> $FILE
# time_sync_nmea_msg
#rosbag record /dji_osdk_ros/time_sync_nmea_msg & echo $! >> $FILE
# time_sync_pps_source
#rosbag record /dji_osdk_ros/time_sync_pps_source & echo $! >> $FILE
# trigger_time
#rosbag record /dji_osdk_ros/trigger_time & echo $! >> $FILE
# velocity
#rosbag record /dji_osdk_ros/velocity & echo $! >> $FILE
# vo_position
#rosbag record /dji_osdk_ros/vo_position & echo $! >> $FILE
# waypointV2_mission_event
#rosbag record /dji_osdk_ros/waypointV2_mission_event & echo $! >> $FILE
# waypointV2_mission_state
#rosbag record /dji_osdk_ros/waypointV2_mission_state & echo $! >> $FILE
