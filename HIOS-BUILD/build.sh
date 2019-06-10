#! /usr/bin/bash
BRANCH=$1
GITHUB_USERNAME=$2
GITHUB_PASSWORD=$3
MODULES=$4
BUILD_ID=$5

IFS=', ' read -r -a array <<< "$MODULES"

  file_name="$MODULES-$BUILD_ID"
  mkdir $file_name
  cd $(echo $file_name | tr -d '\r')
  pwd

  mkdir -p ../release
  mkdir HIOS-BUILD
  mkdir build-artifacts

 /usr/bin/git --version
 /usr/bin/git config --global http.postBuffer 157286400

 GIT_CURL_VERBOSE=1 git clone https://${GITHUB_USERNAME}:${GITHUB_PASSWORD}@github.cms.gov/HIOS/HIOS-BUILD.git -b dev

  for element in "${array[@]}"
   do
  mkdir $(echo $element | tr -d '\r')

  echo -e "cd ${element}"


 GIT_CURL_VERBOSE=1 git clone https://${GITHUB_USERNAME}:${GITHUB_PASSWORD}@github.cms.gov/HIOS/${element}.git -b ${BRANCH} $(echo $element | tr -d '\r')



  cd $(echo $element | tr -d '\r')
  export ANT_HOME=/var/lib/jenkins/tools/hudson.tasks.Ant_AntInstallation/Ant_1.9.6
  export JAVA_HOME=/var/lib/jenkins/tools/hudson.model.JDK/JDK1.8.131
  export PATH=/var/lib/jenkins/tools/hudson.model.JDK/JDK1.8.131/bin:$PATH
  PATH=$PATH:/var/lib/jenkins/tools/node-v7.10.1-linux-x64/bin:/var/lib/jenkins/tools/node-v7.10.1-linux-x64/lib/node_modules/gulp-cli
  export PATH
  java -version

  /var/lib/jenkins/tools/hudson.tasks.Ant_AntInstallation/Ant_1.9.6/bin/ant -file build.xml snapshot -Dbranch.name=DEV -DBRANCH=DEV
  cp dist/*.* ../build-artifacts 2>/dev/null || :
  cp dist/war/*.* ../build-artifacts 2>/dev/null || :
  echo -e "End of checking out and building module ${element}"

  cd ..
  done

  cd build-artifacts
  rm -rf *.xml *.tar
  zip -r $(echo $file_name | tr -d '\r').zip *
  mv *.zip ../../release
  cd ../..
  pwd
  # rm -rf $(echo $file_name | tr -d '\r')
  echo "artifacts can be downloaded from following link:"
  echo "http://hios-devops-jenkins.hios-mgmt.mp.cmscloud.local:8080/job/$JOB_NAME/$BUILD_NUMBER/execution/node/3/ws/release/$(echo $file_name | tr -d '\r').zip"
