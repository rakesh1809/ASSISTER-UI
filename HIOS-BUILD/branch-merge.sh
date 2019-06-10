#!/bin/bash

function usage {
  echo "USAGE: <repo_url> <module> <from> <to>"
  echo ""
  echo "  repo_url      The url of the svn repo"
  echo "  module        The module that was changed"
  echo "  from          The branch name to be merged FROM"
  echo "  to            Optional branch name to be merged onto. Default: HEAD"
  echo ""
}


REPOSITORY_URL=$1
MODULE=$2
FROM=$3
TO=$4
BRANCH=$3

echo  "branch running from $FROM "
echo  "branch variable $BRANCH "

if [ -z $REPOSITORY_URL ] || [ -z $MODULE ] || [ -z $FROM ] || [ -z $TO ] ; then
  echo ""
  echo "ERROR: This script takes in 4 parameters."
  echo ""
  usage
  exit 1
fi


#git svn clone $REPOSITORY_URL/$MODULE -s
echo " branch name $BRANCH "
echo " module name $MODULE "
svn checkout $REPOSITORY_URL/$MODULE/branches/$BRANCH $FROM -q

cd $MODULE

function merge {
  FROM=$1
  TO=$2
  echo "Setting Git Config"
  git config user.email "jenkins@sbd2.com"
  git config user.name "jenkins"

  ANCESTOR=$(git merge-base $FROM $TO)
  touch commits.txt
  git log $ANCESTOR..$FROM >> commits.txt

  git checkout $TO
  git merge $FROM --no-commit
  if [ 1 -eq $? ] ; then
    rm -f commits.txt
    echo -e "\n\n"
    echo "ERROR MERGE FAILED PLEASE MERGE: "
    echo "      "$FROM
    echo "INTO "
    echo "      "$TO
    echo -e "\n\n"
    echo "The following files need merged: "
    git status --porcelain
    echo -e "\n\n"
    exit 1
  fi
  git commit -F commits.txt
  rm -f commits.txt
  pwd
  echo "^PWD"
#  git svn dcommit

}

#merge $FROM $TO
#merge $TO $FROM


