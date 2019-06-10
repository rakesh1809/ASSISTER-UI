ps -ef|grep UIPartition_ap01|grep -v grep | awk '{print $2}' | xargs kill


