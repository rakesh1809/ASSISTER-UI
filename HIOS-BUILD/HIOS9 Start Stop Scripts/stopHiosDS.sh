#!/bin/sh
#export PATH=/usr/local/java/jdk1.6.0_27/bin:$PATH
#export JAVA_HOME=/usr/local/java/jdk1.6.0_27

#./shutdown.sh -s 10.200.1.18 admin -p Rbis123 -S

ps -ef|grep RBISDS|grep -v grep | awk '{print $2}' | xargs kill

