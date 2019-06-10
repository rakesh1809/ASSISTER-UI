ps -ef|grep APIPartition|grep -v grep | awk '{print $2}' | xargs kill



