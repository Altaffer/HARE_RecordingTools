#!/usr/bin/env python3
import rospy
import rosbag
from sensor_msgs.msg import NavSatFix

import os

RECORDING_LOCATION = "/media/jetson/hareflightdisk00/"

GPS_TOL = 0.02

# find the most recent bag file

list_dir = os.listdir(RECORDING_LOCATION)
list_dir = [f for f in list_dir if ".bag" in f]
list_dir = sorted(list_dir, reverse=True)

# read that bag file and determine what percentage of the gps pings are good

print("most recent bag is", list_dir[0])
bag = rosbag.Bag(os.path.join(RECORDING_LOCATION, list_dir[0]))

counter_good = 0
counter_bad = 0

for topic, msg, t in bag.read_messages(topics=['/ublox/fix']):
	if msg.position_covariance[0] > GPS_TOL:
		counter_bad += 1
	else:
		counter_good += 1

print("ratio of good to bad gps positions", counter_good/counter_bad)

bag.close()
