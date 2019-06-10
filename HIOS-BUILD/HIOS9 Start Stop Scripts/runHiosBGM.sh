#!/bin/sh
#
export  PATH=/usr/local/java/jdk1.6.0_27/bin:$PATH
export JAVA_HOME=/usr/local/java/jdk1.6.0_27
export JBOSS_HOME=/opt/jboss-soa-p/jboss-as

echo "Removing temporary working directories..";
rm -rf $JBOSS_HOME/server/bgm/tmp
rm -rf $JBOSS_HOME/server/bgm/work

echo "Starting server....";
umask 000
nohup $JBOSS_HOME/bin/run.sh -b 10.200.1.18 -c bgm -Djboss.messaging.ServerPeerID=2 -Djboss.service.binding.set=ports-01 -g BGMPARTITION &

tail -f /opt/jboss-soa-p/jboss-as/server/bgm/log/server.log

