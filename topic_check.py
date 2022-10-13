# Hey luca, leave this file for now, I want to see how yours works first

import rospy
from sensor_msgs.msg import Imu, Image, NavSatFix
import sys
import time

class TopicAnalysis:
	def __init__(self, topic_name, hz, msg_type, tollerance, custom_check):
		self.topic = topic_name
		self.rate = hz
		self.last_time = rospy.get_time()
		self.reported = False
		self.diagnostic_sub = rospy.Subscriber(topic_name, msg_type, self.callback)
		if custom_check == None:
			self.extra_check = self.ret_true
		else:
			self.extra_check = custom_check
		if tollerance > 1 or tollerance < 0:
			print("tollerance must be between 0 and 1 (ex: 0.02) for ", topic_name)
			sys.exit(1)
		else:
			self.tol = tollerance


	def callback(self, msg):
		if self.reported == False:
			dt = 1 / (rospy.get_time() - self.last_time)
			if dt > (1.0-self.tol) * self.rate and dt < (1.0+self.tol) * self.rate and self.extra_check(msg):
				print(self.topic, " is good to go")
				self.reported = True
			self.last_time = rospy.get_time()


	def ret_true(self, msg):
		return True


def gps_check(msg):
	# fix this, cov is the wrong name
	if msg.position_covariance[0] < 500:
		return True
	return False




# configure topics, hz, message type, tolelrance, and any custom checks
cfg = {
	# topic             [ hz,   type, tollerance,  custom check ]
	"/dji_osdk_ros/imu": [400, Imu, 0.02, None],
	"/ublox/fix": [8, NavSatFix, 0.02, gps_check]
}









print("topic check started")
rospy.init_node('validator', anonymous=True)

topics = []

for key in cfg:
	h = cfg[key]
	topics.append(TopicAnalysis(key, h[0], h[1], h[2], h[3]))

while len(topics) > 0:
	print("checking topics")
	for t in range(len(topics)):
		if topics[t].reported:
			topics.pop(t)

	time.sleep(2)

print("===================================\n Go for flight \n==================================")
sys.exit(0)


# maybe start recording from here?
