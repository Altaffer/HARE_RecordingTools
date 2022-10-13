# Hey luca, leave this file for now, I want to see how yours works first

import rospy
import json

class TopicAnalysis:
	def __init__(self, topic_name, hz, msg_type, custom_check=None):
		self.topic = topic_name
		self.rate = hz
		self.last_time = rospy.get_time()
		self.reported = False
		self.diagnostic_sub = rospy.Subscriber(topic_name, msg_type, self.callback)
		if custom_check == None:
			self.extra_check = self.ret_true
		else:
			self.extra_check = custom_check


	def callback(self, msg):
		if self.reported == False:
			dt = 1 / (rospy.get_time() - self.last_time)
			if dt > 0.99 * self.rate and dt < 1.01 * self.rate and self.extra_check(msg):
				print(self.topic, " is good to go")
				self.reported = True
			self.last_time = rospy.get_time()


	def ret_true(self, msg):
		return True


def gps_check(msg):
	# fix this, cov is the wrong name
	if msg.covariance[0] < 100:
		return True
	return False


if __name__ == '__main__':
	rospy.init_node('validator', anonymous=True)

	f = open('')
	d = json.load(f)

	topics = []

	for key in d:
		h = d[key]
		topics.append(h['topic_name'], h['hz'], h['type'])
