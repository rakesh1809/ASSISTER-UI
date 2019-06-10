#!/bin/bash

count=$(sqlite3 /opt/jenkins/scripts/test.db "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND tbl_name NOT LIKE 'MODULE%'")

username=serviceaccount
api_token=13c7ed183ce4b302029a0a17f7381b55

i=0
j=1

while [ $j -le $count ]
do
  names[$i]=$(sqlite3 /opt/jenkins/scripts/test.db "SELECT name FROM sqlite_master WHERE type='table' AND tbl_name NOT LIKE 'MODULE% LIMIT $i,$j")
  i=$(( i+1 ))
  j=$(( j+1 ))
done

if [ $count -gt 0 ] 
then
  for i in "${names[@]}"
  do
    echo $i
    curl -X POST "$username:$api_token@10.200.1.16:8080/jenkins/job/BUILD_HIOS/buildWithParameters?token=token123&BRANCH=$i"
  done
fi
