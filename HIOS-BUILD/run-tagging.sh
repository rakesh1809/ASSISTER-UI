#!/bin/bash
set +x
echo "Tagging modules for release"

# TODO: get this variable from jenkins.
export ANT_HOME=/home/tomcat7/.jenkins/tools/hudson.tasks.Ant_AntInstallation/Ant_1.9.6
export JAVA_HOME=/home/tomcat7/.jenkins/tools/hudson.model.JDK/JDK1.8.131
export PATH=/home/tomcat7/.jenkins/tools/hudson.model.JDK/JDK1.8.131/bin:$PATH

modules="/opt/jenkins/scripts/modules.txt"
while read -r line
do
    module="$line"
    echo "*****"
    echo "TAG FOR: $module"
	svn copy https://calt.cms.gov/svn/repos/svnhios/${module}/branches/${BRANCH} https://calt.cms.gov/svn/repos/svnhios/${module}/tags/${BUILD_GUID} -m "Tagging ${BUILD_GUID}"

    cd ..
done < $modules

wait
