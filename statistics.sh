#!/bin/bash

time=$(date -u +"%T-%m-%d_%H:%M:%S")
root=$(cat /etc/group | grep 'sudo' | cut -d ':' -f 4)
num=$(cat /etc/passwd | grep /home/ | wc -l)
current_user=$(w -h | awk '{print $1"_"$3"_"$2}' | xargs | tr " " "," )
last_user=$(last | grep "[a-z]" | grep -v "wtmp" | awk '{print $1}' | sort | uniq -c | tail -n 3 | awk '{print $2}' | xargs | tr " " ",")
echo $time $num [$last_user] [$root] [$current_user]
