#!/bin/bash

echo $#
#saving data to txt file
#FILE=pdata.txt
SSD=/media/jetson/hareflightbag01
#clear pids.txt, touch pids.txt
#rm $FILE; touch $FILE

# roscore in background
roscore & echo $!
# sleep to allow roscore to enable
sleep 10

rosbag play $SSD/$(ls $SSD -t | head -n1)

# rviz configuration
