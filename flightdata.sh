#!/bin/bash

# saving the data to a text file
FILE=fdata.txt

# clearing the file and making a new one
rm fdata.txt; touch fdata.txt

# launching the vehcile node to the background and save data to the flight data file 
roslaunch ~/catkin_ws/src/Onboard-SDK-ROS/launch/dji_vehicle_node.launch & echo $! >> $FILE
#cd ~/catkin_ws/src/Onboard-SDK-ROS/launch
#roslaunch dji_vehicle_node.launch & echo $! >> $FILE


# recording the topics
rosbag record /dji_osdk_ros/attitude /dji_osdk_ros/battery_state /dji_osdk_ros/flight_status /dji_osdk_ros/height_above_takeoff /dji_osdk_ros/imu /dji_osdk_ros/gps_position /dji_osdk_ros/local_position /dji_osdk_ros/rc /dji_osdk_ros/rc_connection_status /dji_osdk_ros/velocity & echo $! >> $FILE

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
