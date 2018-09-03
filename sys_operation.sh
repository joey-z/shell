#!/bin/bash

# 时间
time=$(date +"%Y-%m-%d_%H:%M:%S")

# 主机名 os版本  um[0] um[1]
um=$(uname -a | awk '{printf $2" "$3}')

# 内核版本
nh=$(cat /etc/issue)

# 运行时间  
running_time=$(uptime -p | tr " " "_")

# 平均负载
avg=$(uptime | tr " " "\n" | tail -n 3 | tr "\n" " ")

# 磁盘大小 磁盘已用
disk=( $(df -m | grep "^/dev" | awk '{a+=$2;b+=$3}END{printf("%d\t%d"), a, b}') )

# 磁盘已用%
disk_used=$[ ${disk[1]}*100/${disk[0]} ]

# 内存总量 mem[0] 已使用mem[1]
mem=( $(free -m | head -n 2 | tail -n 1 | awk '{print $2" " $3}') )
#echo "${mem[0]}"
# 已用%
mem_used=$[ ${mem[1]}*100/${mem[0]} ]

# CPU温度 
temperature=$[ $(cat /sys/class/thermal/thermal_zone0/temp)]
C_temperature=$( echo "scale=2; ${temperature} / 1000" | bc )

echo -e "$time ${um[0]} ${um[1]} $nh $running_time $avg ${disk[0]} ${disk_used}% ${mem[0]} ${mem_used}% $C_temperature\c"

# 磁盘报警级别
if [[ $disk_used -lt 80  ]];then
    echo -e "\033[32m normal \c\033[0m"
elif [[ $disk_used -lt 90 ]];then
    echo -e "\033[34m note \033[0m"
else
    echo -e "\033[31m warning \033[0m"
fi

# 内存报警级别
if [[ $mem_used -lt 70 ]];then
    echo -e "\033[32m normal \c\033[0m"
elif [[ $mem_used -lt 80 ]];then
    echo -e "\033[34m note \033[0m"
else 
    echo -e "\033[31m warning \033[0m"
fi

# CPU报警级别
if [[ $(echo "$C_temperature < 50.00" | bc)  -eq 1 ]];then 
    echo -e "\033[32m normal \c\033[0m"
elif [[ $(echo "$C_temperature < 50.00" | bc)  -eq 1 ]];then
    echo -e "\033[34m note \033[0m"
else
     echo -e "\033[31m warning \033[0m"
 fi
