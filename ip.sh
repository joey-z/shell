#!/bin/bash

ip=192.168.1.
for i in `seq 1 254`
do
    ping -c 2 -t 1 $ip$i > /dev/null 2>&1
    if [[ `echo $?` -eq 0 ]];then
        echo -e "$ip$i"
    fi
done
