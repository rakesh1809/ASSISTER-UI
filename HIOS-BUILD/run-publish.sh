#!/bin/bash
set +x
echo "getting the modules that have changed for the branch"
count=$(sqlite3 /opt/jenkins/scripts/test.db "SELECT COUNT(*) FROM '${BRANCH}'")
echo "COUNT: $count"

echo "Below is the list of modules to be published"
sqlite3 /opt/jenkins/scripts/test.db "SELECT * FROM '${BRANCH}';"
echo "End of the list of modules to be published"

# TODO: get this variable from jenkins.
export ANT_HOME=/home/tomcat7/.jenkins/tools/hudson.tasks.Ant_AntInstallation/Ant_1.9.6
export JAVA_HOME=/home/tomcat7/.jenkins/tools/hudson.model.JDK/JDK1.8.131
export PATH=/home/tomcat7/.jenkins/tools/hudson.model.JDK/JDK1.8.131/bin:$PATH






a=0
b=1

while (( $b <= $count ))
do
    echo "*****"
    echo "count: $count"
    echo "a: $a"
    echo "b: $b"
    echo "*****"
    modules=$(sqlite3 /opt/jenkins/scripts/test.db "SELECT * FROM '${BRANCH}' LIMIT $a,$b")
    a=$(( a+1 ))
    b=$(( b+1 ))
    echo "PUBLISH RELEASE FOR: $modules"
    pwd
    cwd=$(pwd)
    echo "PWD^"
    ls
    echo "ls^"
    #consider doing the compile here.
	echo "changing to directory ${cwd}/${modules}"
	cd $(echo $modules | tr -d '\r')
	pwd
	echo "PWD^ again"
	echo "HERE IS WHERE I WILL RUN ANT RELEASE for $modules"
    /home/tomcat7/.jenkins/tools/hudson.tasks.Ant_AntInstallation/Ant_1.9.6/bin/ant -file build.xml -Dbranch.name=${BRANCH} -DBRANCH=${BRANCH} release
    if [ 1 -eq $? ] ; then
      echo "***************"
      echo "ERROR: There is no build file!"
      echo "***************"
      exit 1
    fi


    cd $(echo $cwd | tr -d '\r')
done

wait
