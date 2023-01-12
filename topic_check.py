#!/usr/bin/env python3
import subprocess
import rospy
from sensor_msgs.msg import Imu, Image, NavSatFix, BatteryState, Joy
from geometry_msgs.msg import QuaternionStamped, PointStamped, Vector3Stamped
from std_msgs.msg import UInt8, Float32
import os
import sys
import time
from scipy import stats
from micasense_wedge.msg import micasense
RECORDING_LOCATION = "/media/jetson/hareflightdisk00/"
#RECORDING_LOCATION = "~/"
class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


class TopicAnalysis:
	def __init__(self, topic_name, hz, msg_type, tolerance, custom_check):
		self.topic = topic_name
		self.rate = hz
		self.last_time = rospy.get_time()
		self.reported = False
		self.diagnostic_sub = rospy.Subscriber(topic_name, msg_type, self.callback)
		if custom_check == None:
			self.extra_check = self.ret_true
		else:
			self.extra_check = custom_check
		if tolerance > 1 or tolerance < 0:
			print(f"{bcolors.FAIL}tollerance must be between 0 and 1 (ex: 0.02) for ", topic_name)
			sys.exit(1)
		else:
			self.tol = tolerance


	def callback(self, msg):
		if self.reported == False:
			dt = 1 / (rospy.get_time() - self.last_time)
			if dt > (1.0-self.tol) * self.rate and dt < (1.0+self.tol) * self.rate and self.extra_check(msg):
				print(f"{bcolors.OKGREEN}{self.topic} is good to go")
				self.reported = True
			self.last_time = rospy.get_time()


	def ret_true(self, msg):
		return True


def gps_check(msg):
	# fix this, cov is the wrong name
	gps_check.counter += 1
	if msg.position_covariance[0] < 0.03:
		return True
	if gps_check.counter == 100:
		print(f"{bcolors.WARNING}ubx accuracy: {msg.position_covariance[0]}")
		gps_check.counter = 0
	return False

gps_check.counter = 0



def image_check(msg):
	if msg.data.all == 0:
		return False
	k2, p = stats.normaltest(msg.data[0:msg.width*msg.height])
	if p < 1e-3:
		# normal distribution, we're good
		return True
	else:
		# not a normal distribution 
		return False



# configure topics, hz, message type, tolelrance, and any custom checks
cfg = {
	# topic             [ hz,   type, tolerance,  custom check ]
	"/dji_osdk_ros/imu": [400, Imu, 0.02, None],
	"/dji_osdk_ros/battery_state": [5, BatteryState, 0.02, None],
	"/dji_osdk_ros/attitude": [100, QuaternionStamped, 0.02, None],
	"/dji_osdk_ros/local_position": [50, PointStamped, 0.02, None],
	"/dji_osdk_ros/rc": [50, Joy, 0.02, None],
	"/dji_osdk_ros/velocity": [50, Vector3Stamped, 0.02, None],
	"/dji_osdk_ros/gps_position": [50, NavSatFix, 0.02, None],
	"/dji_osdk_ros/gps_health": [50, UInt8, 0.2, None],
	"/dji_osdk_ros/flight_status": [50, UInt8, 0.05, None],
	"/dji_osdk_ros/height_above_takeoff": [50, Float32, 0.05, None],
	"/cam0/camera/image_raw": [5, Image, 0.01, None],
	"/cam1/camera/image_raw": [5, Image, 0.01, None],
	"/therm/image_raw_throttle": [5, Image, 0.5, None],
	"/ublox/fix": [8, NavSatFix, 0.02, gps_check],
	"/micasense_data": [1, micasense, 0.99, None]
}




print("topic check started")
print(f"{bcolors.OKBLUE}=================================\nctrl-\ to exit\n======================================")
rospy.init_node('validator', anonymous=True)

topics = []

topics_s = ""
for key in cfg:
	h = cfg[key]
	topics_s += key + " "
	topics.append(TopicAnalysis(key, h[0], h[1], h[2], h[3]))


check_time = 2
been_through = False
while len(topics) > 0:
	# print("checking ", len(topics), " topics")
	for t in topics:
		if t.reported:
			topics.remove(t)
		if len(topics) < 3 and been_through == True:
			check_time = 10
		print(f"{bcolors.WARNING}checking {t.topic}")

	been_through = True

	time.sleep(check_time)

print(f"{bcolors.OKCYAN}==================================\n Go for flight \n==================================")
# sys.exit(0)


# maybe start recording from here?
# recording_cmd = "rosbag record -o " + RECORDING_LOCATION + " " + topics_s
os.system('rosbag record -o '+RECORDING_LOCATION + " " + topics_s + " & echo $! >> fdata.txt" )
# with open("fdata.txt", "a") as file:
# 	file.write(pid)
sys.exit(0)
