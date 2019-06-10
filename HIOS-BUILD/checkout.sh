#!/bin/bash

# $1 = module name
# $2 = svn repo
# $3 = branch

if [ -d "$1" ] ; then 
	echo "I already checked out $1 with git-svn";
else
	#This will need to be changed to trunk once the ivy stuff gets in. 
	echo "svn co $2/$1/branches/$3 $1"
	svn checkout $2/$1/branches/$3 $1 -q
fi 	
export PATH=$PATH:/usr/local/git/bin