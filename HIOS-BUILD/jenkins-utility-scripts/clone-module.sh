#!/bin/bash
cd /home/tomcat7/.jenkins/jobs/SVN-Polling/workspace/hios/$2
git svn clone $1/$2/branches/$3 -q 
