#!/bin/bash

pid=($(ps -aux | awk '$3 > 30 || $4 > 50 {print $2}'))

if [[ $pid ]]; then
    sleep 5
else
    echo "没有发现恶意进程"
    exit
fi
#echo "${#pid[@]}"

time_now=$( date -u +"%Y-%m-%d__%H:%m:%S" )

while [[ i -lt ${#pid[@]} ]]; do 
    result=( $( ps -aux | awk '$3 > 30 || $4 > 50 {print $1" "$2" "$3" "$4" "$11}'  ) ) 

    if [[ ${result[1 + i*5]} == ${pid[i]} ]]; then
        #echo "${pid[i]}"
        echo "$time_now ${result[4 + i*5]} ${result[1 + i*5]} ${result[0 + i*5]} ${result[2 + i*5]}% ${result[3 + i*5]}% " 
        #pid[i]=0
    fi
    let i++
done

