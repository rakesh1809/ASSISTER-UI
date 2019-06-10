#!/bin/usr/bash

#here i will cd into dir and get the commit hash

cd /home/tomcat7/.jenkins/jobs/SVN-Polling/workspace/hios/$1/$2
commit=$(git log -n 1 --pretty=format:'%H')
echo $commit

