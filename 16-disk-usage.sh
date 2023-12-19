#!/bin/bash

DISK_USAGE=$(df -hT | grep -vE 'tmp|File')
DISK_THRESHOLD=1
message=""

while IFS= read line
do  
    usage=$(echo $line | awk '{print $6F}' | cut -d % -f1)|
    partition=$(echo $line | aws '{print $1F}')
    if [$usage -gt $DISK_THRESHOLD]
    then
        message+="High disk usage on $partition: $usage"
    fi
done <<< $DISK_USAGE