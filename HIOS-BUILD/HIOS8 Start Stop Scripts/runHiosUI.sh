#!/bin/sh
export PATH=/usr/local/java/jdk1.6.0_27/bin:$PATH
export JAVA_HOME=/usr/local/java/jdk1.6.0_27
export JBOSS_HOME=/opt/jboss-soa-p/jboss-as

cd $JBOSS_HOME/server/ui
rm -rf tmp work
echo 'tmp and work removed'
cd $JBOSS_HOME/bin
umask 000
nohup ./run.sh -c ui -b 10.200.1.17 -g UIPartition_ap01 -Djboss.messaging.ServerPeerID=4 -Djboss.server.log.threshold=INFO &
