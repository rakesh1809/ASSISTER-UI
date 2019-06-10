#!/bin/bash
set +x

echo "Setting the order of module execution"

FILE=build-modules.txt
k=1
sqlite3 /opt/jenkins/scripts/test.db "DROP TABLE MODULE_TXT;"
sqlite3 /opt/jenkins/scripts/test.db "CREATE TABLE IF NOT EXISTS MODULE_TXT (MODULE TEXT NOT NULL, BUILD_PRIORITY INT NOT NULL );"
while read line;do
       # echo " line from file: ${line}"
       # echo "${k}"
       if [ -n "$line" ]; then
        sqlite3 /opt/jenkins/scripts/test.db "INSERT INTO MODULE_TXT (MODULE,BUILD_PRIORITY) VALUES ('$(echo $line | tr -d '\r')','${k}');"
       fi
        ((k++))
done < $FILE

FILE=module-order.txt
m=1
sqlite3 /opt/jenkins/scripts/test.db "DROP TABLE MODULE_ORDER;"
sqlite3 /opt/jenkins/scripts/test.db "CREATE TABLE IF NOT EXISTS MODULE_ORDER (MODULE TEXT NOT NULL, BUILD_PRIORITY INT NOT NULL );"
while read line1;do
        #echo " line from file: ${line1}"
        #echo "${m}"
        if [ -n "$line1" ]; then
        sqlite3 /opt/jenkins/scripts/test.db "INSERT INTO MODULE_ORDER (MODULE,BUILD_PRIORITY) VALUES ('$(echo $line1 | tr -d '\r')','${m}');"
        fi
        ((m++))
done < $FILE

LIST=`sqlite3 /opt/jenkins/scripts/test.db "SELECT distinct d.MODULE FROM '${BRANCH}' d,MODULE_ORDER mo where d.MODULE NOT IN (SELECT MODULE FROM MODULE_TXT) and mo.module=d.module order by mo.build_priority "`;
for ROW in $LIST; do
       #echo "row from '${BRANCH}' table : ${ROW}"
       sqlite3 /opt/jenkins/scripts/test.db "INSERT INTO MODULE_TXT (MODULE,BUILD_PRIORITY) VALUES ('$(echo $ROW | tr -d '\r')','${k}');"
       ((k++))
done
sqlite3 /opt/jenkins/scripts/test.db "DELETE FROM '${BRANCH}';"
sqlite3 /opt/jenkins/scripts/test.db "INSERT INTO '${BRANCH}' SELECT MODULE FROM MODULE_TXT ORDER BY BUILD_PRIORITY;"

echo "************Changes detected in following Modules (This may include mandatory build modules)************************"
sqlite3 /opt/jenkins/scripts/test.db "SELECT * FROM '${BRANCH}';"

echo "************End of Changes detected in following Modules ************************"

