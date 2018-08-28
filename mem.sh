#!/bin/bash


#输入
num=$1

#当前时间
time=$(date -u +"%Y-%m-%d_%H:%M:%S")

#free命令查看内存占用情况 awk输出 总量 当前占用 剩余量
size=( $(free -m | head -n 2 | tail -n 1 | awk '{print $2" "$3" "$2-$3}') )

#当前占用比 保留一位小数 
occupy=$(echo "scale=1;${size[1]}*100/${size[0]}" | bc)

#动态平均值=0.3动态平均值（上一次）+0.7当前占用比
#占用百分比动态平均值
avg=$(echo "scale=1;0.3*$1+0.7*${occupy}" | bc)

#时间 	总量 	剩余量 	当前占用（%）占用百分比动态平均值
echo "$time ${size[0]}M ${size[2]}M ${occupy}% ${avg}%"

