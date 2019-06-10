#!/bin/bash

modules=$(sqlite3 /opt/jenkins/scripts/test.db "SELECT * FROM ivytest_coveros")

echo ${modules}

mod="HIOS-MAIN-DATA"
mod2="HIOS-API"
/usr/local/bin/python2.7 /opt/jenkins/scripts/digraph.py $mod $mod2
