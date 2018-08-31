#!/bin/bash

time=$(date +"%Y-%m-%d_%H:%M:%S")
echo -e "$time" "\c"
# 负载1（1分钟） 负载2（5分钟） 负载3（15分钟） 
load=$(uptime | tr " " "\n" | tail -n 3 | tr "\n" " ")
echo -e "$load\c"

c_occupy=(`cat /proc/stat | head -n 1 | awk '{print ($2+$3+$4+$5+$6+$7+$8" "$5)} '`)
sleep 0.5 
c_occupy1=(`cat /proc/stat | head -n 1 | awk '{print ($2+$3+$4+$5+$6+$7+$8" "$5)}'`)
temp=`echo ${c_occupy[0]} ${c_occupy[1]} ${c_occupy1[0]} ${c_occupy1[1]} | awk '{printf("%.2f", 100 - ($4 - $2) * 100.0/ ($3 - $1))}'` 
echo -e "$temp%" "\c "

#cpu温度 
temperature=$[ $(cat /sys/class/thermal/thermal_zone0/temp) ]
C_temperature=$( echo "scale=2; ${temperature} / 1000" | bc  )
echo -e "$C_temperature℃\c"
# CPU报警级别
if [[ $(echo "$C_temperature < 50.00" | bc)  -eq 1  ]];then 
    echo -e "\033[32m normal \033[0m"
elif [[ $(echo "$C_temperature < 50.00" | bc)  -eq 1  ]];then
    echo -e "\033[34m note \033[0m"
else
    echo -e "\033[31m warning \033[0m"
fi

