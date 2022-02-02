#!/usr/bin/env python
#Every Python Node will have this declaration at the top.
#It makes sure that the script is executed as a Python script.


## Simple talker demo that published std_msgs/Strings messages
## to the 'chatter' topic

import rospy #import rospy library 
from std_msgs.msg import String #import the type of message from std_msgs.msg

#Class Publisher:
#rospy.Publisher("Topic", std_msgs.msg."type_of_message", queue_size)
#queue_size -> limits the amount of queued messagesz if any subscriber is not receiving them fast enough.
#Publisher Class takes those parameters to be created.


#Funtion init_node:
#rospy.init_node("Node_Name", anonymous = True)
#anonymous = True -> ensures that the node has a unique name by adding random number to the end of Node_Name. 
#init_node is very important because it tells rospy the Node_Name.
#rospy can't start communicating with the ROS master without the name of the node.

#Class Rate:
#rospy.Rate("frequency in Hertz")
#Makes the program loop at the desired rate.



def talker():
    pub = rospy.Publisher('chatter', String, queue_size=10)
    rospy.init_node('talker', anonymous=True)
    rate = rospy.Rate(10) # 10hz
    while not rospy.is_shutdown():
        hello_str = "hello world %s" % rospy.get_time()
        rospy.loginfo(hello_str)
        pub.publish(hello_str)
        rate.sleep()


#While Loop:
#This while loop is a fairly standard rospy construct.
#The loop keeps checking for rospy.is_shutdown() function.
#It checks if the program should exit or not.
#This loop also calls rospy.loginfo(str), which performs triple-duty: the messages get printed to screen, it gets written to the Node's log file, and it gets written to rosout.

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass
