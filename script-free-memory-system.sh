#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
percentFree=$(free | grep Mem | awk '{print $4/$2 * 100.0}')
logPath="$DIR/log_memory"

echo -e "\n\n\n\n\n" >> $logPath
echo "$(date) ----> Checking memory" >> $logPath
echo "Percent free ====> $percentFree" >> $logPath

if [ "$(echo $percentFree '<' 30 | bc -l)" -eq 1 ]
then
        echo "Low memory, free right now" >> $logPath
        /bin/echo 3 > /proc/sys/vm/drop_caches
        echo "Percent memory after free: $(free | grep Mem | awk '{print $4/$2 * 100.0}')" >> $logPath
else
        echo "Normal memory, do nothing" >> $logPath
fi

