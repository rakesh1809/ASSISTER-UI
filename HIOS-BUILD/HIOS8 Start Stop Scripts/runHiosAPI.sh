#!/bin/sh
export PATH=/usr/local/java/jdk1.6.0_27/bin:$PATH
export JAVA_HOME=/usr/local/java/jdk1.6.0_27
export JBOSS_HOME=/opt/jboss-soa-p/jboss-as

cd $JBOSS_HOME/server/api
rm -rf tmp work
echo 'tmp and work removed'
cd $JBOSS_HOME/bin
umask 000
nohup ./run.sh -c api -b 10.200.1.17 -g APIPartition -Djboss.messaging.ServerPeerID=3 -Djboss.service.binding.set=ports-01 -Djboss.server.log.threshold=DEBUG &
