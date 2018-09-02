#!/bin/bash

time=$(date +"%Y-%m-%d_%H:%M:%S")
# 分区1总量 占用 剩余  挂载点  分区2总量 占用  剩余 挂载点 
# 磁盘总量  磁盘已用 磁盘剩余量 占用比
disk=( $(df -m | grep "^/dev" | awk '{print $2" "$3" "$2-$3" " $6}{a+=$2;b+=$3;c=a-b;d=b*100/a}END{printf("%d %d %d %.2f",a, b, c, d)}' | tr "\n" " " ))
#分区占用比1 分区占用比2

occpy1=$[ ${disk[1]}*100/${disk[0]} ]
occpy2=$[ ${disk[5]}*100/${disk[4]} ]

echo "$time 0 disk ${disk[8]} ${disk[10]} ${disk[11]}"

echo "$time 1 ${disk[3]} ${disk[0]} ${disk[2]} $occpy1"

echo "$time 1 ${disk[7]} ${disk[4]} ${disk[6]} $occpy2"
