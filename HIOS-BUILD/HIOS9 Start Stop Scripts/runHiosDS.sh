
#!/bin/sh
#
export PATH=/usr/local/java/jdk1.6.0_27/bin:$PATH
export JAVA_HOME=/usr/local/java/jdk1.6.0_27/
export JBOSS_HOME=/opt/jboss-soa-p/jboss-as
INSTANCE="ds";

echo "Removing temporary working directories..";

rm -rf $JBOSS_HOME/server/$INSTANCE/data
#rm -rf $JBOSS_HOME/server/$INSTANCE/log
rm -rf $JBOSS_HOME/server/$INSTANCE/tmp
rm -rf $JBOSS_HOME/server/$INSTANCE/work

echo "Starting server..";

umask 000


nohup $JBOSS_HOME/bin/run.sh -b 10.200.1.18 -c $INSTANCE -Djboss.messaging.ServerPeerID=3 -g RBISDS &


