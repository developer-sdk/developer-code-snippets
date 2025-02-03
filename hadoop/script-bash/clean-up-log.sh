#!/bin/bash

function echo_red() {
    RED='\033[0;31m'
    NC='\033[0m'  # Color off
    echo -e ${RED}$1${NC}
}

function echo_green() {
    GREEN='\033[0;32m'
    NC='\033[0m'  # Color off
    echo -e ${GREEN}$1${NC}
}

vCommand='
if [ -d /var/log/hadoop ]; then
    echo "delete... /var/log/hadoop"
    find /var/log/hadoop -name "*.log*" -mtime +14 -delete
    find /var/log/hadoop -maxdepth 1 \( \( -name "*.log*" -or -name "*.out" -or -name "SecurityAuth*" \) -and -not -name "*.gz" \) -type f -mtime +2 -exec gzip -f {} \;
    find /var/log/hadoop -name "*.gz" -mtime +14 -delete
fi

if [ -d /var/log/hadoop-yarn ]; then
    echo "delete... /var/log/hadoop-yarn"
    find /var/log/hadoop-yarn -name "*.log*" -mtime +14 -delete
    find /var/log/hadoop-yarn -maxdepth 1 \( \( -name "*.log*" -or -name "*.out" -or -name "SecurityAuth*" \) -and -not -name "*.gz" \) -type f -mtime +2 -exec gzip -f {} \;
    find /var/log/hadoop-yarn -name "*.gz" -mtime +14 -delete
fi

if [ -d /var/log/hadoop-mapreduce ]; then
    echo "delete... /var/log/hadoop-mapreduce"
    find /var/log/hadoop-mapreduce -name "*.log*" -mtime +14 -delete
    find /var/log/hadoop-mapreduce -maxdepth 1 \( \( -name "*.log*" -or -name "*.out" -or -name "SecurityAuth*" \) -and -not -name "*.gz" \) -type f -mtime +2 -exec gzip -f {} \;
    find /var/log/hadoop-mapreduce -name "*.gz" -mtime +14 -delete
fi

if [ -d /var/log/hive ]; then
    echo "delete... /var/log/hive"
    find /var/log/hive -name "*.log*" -mtime +14 -delete
    find /var/log/hive -maxdepth 1 \( \( -name "*.log*" -or -name "*.out" -or -name "SecurityAuth*" \) -and -not -name "*.gz" \) -type f -mtime +2 -exec gzip -f {} \;
    find /var/log/hive -name "*.gz" -mtime +14 -delete
fi

if [ -d /var/log/hive-hcatalog ]; then
    echo "delete... /var/log/hive-hcatalog"
    find /var/log/hive-hcatalog -name "*.log*" -mtime +14 -delete
    find /var/log/hive-hcatalog -maxdepth 1 \( \( -name "*.log*" -or -name "*.out" -or -name "SecurityAuth*" \) -and -not -name "*.gz" \) -type f -mtime +2 -exec gzip -f {} \;
    find /var/log/hive-hcatalog -name "*.gz" -mtime +14 -delete
fi

if [ -d /var/log/hbase ]; then
    echo "delete... /var/log/hbase"
    find /var/log/hbase -name "*.log*" -mtime +14 -delete
    find /var/log/hbase -maxdepth 1 \( \( -name "*.log*" -or -name "*.out" -or -name "SecurityAuth*" \) -and -not -name "*.gz" \) -type f -mtime +2 -exec gzip -f {} \;
    find /var/log/hbase -name "*.gz" -mtime +14 -delete
fi

if [ -d /var/log/spark ]; then
    echo "delete... /var/log/spark"
    find /var/log/spark -name "*.log*" -mtime +14 -delete
    find /var/log/spark -maxdepth 1 \( \( -name "*.log*" -or -name "*.out" -or -name "SecurityAuth*" \) -and -not -name "*.gz" \) -type f -mtime +2 -exec gzip -f {} \;
    find /var/log/spark -name "*.gz" -mtime +14 -delete
fi

if [ -d /var/log/zookeeper ]; then
    echo "delete... /var/log/zookeeper"
    find /var/log/zookeeper -name "*.log*" -mtime +14 -delete
    find /var/log/zookeeper -maxdepth 1 \( \( -name "*.log*" -or -name "*.out" -or -name "SecurityAuth*" \) -and -not -name "*.gz" \) -type f -mtime +2 -exec gzip -f {} \;
    find /var/log/zookeeper -name "*.gz" -mtime +14 -delete
fi

if [ -d /var/log/oozie ]; then
    echo "delete... /var/log/oozie"
    find /var/log/oozie -name "*.log*" -mtime +14 -delete
    find /var/log/oozie -maxdepth 1 \( \( -name "*.log*" -or -name "*.out" -or -name "SecurityAuth*" \) -and -not -name "*.gz" \) -type f -mtime +2 -exec gzip -f {} \;
    find /var/log/oozie -name "*.gz" -mtime +14 -delete
fi
'

vNodes=(server1
server2)

# run command
for vNode in "${vNodes[@]}"
do
    echo_green "----- ${vNode} -----"
    ssh -i ~/.ssh/keypair.pem -o StrictHostKeyChecking=no ubuntu@${vNode} "bash -c '${vCommand}'"
done