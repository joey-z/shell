#!/bin/bash

MAX_N=10000

for ((i=0; i<MAX_N; i ++));
do
    prime[i]=0
done

for ((i=2; i<MAX_N; i ++));
do
    if [[ $[prime[i]] -eq 0 ]];then
        (( prime[0]++ ))
        prime[${prime[0]}]=$i
    fi
    for ((j=1; j<=prime[0]; j ++));
    do
        if [[ $[$i * ${prime[j]}] -gt $MAX_N ]];then
            break
        fi
        prime[$i * ${prime[j]}]=1
        if [[ $[$i % ${prime[j]}] -eq 0 ]];then
            break
        fi
    done
done

    for ((i=1; i<=${prime[0]}; i ++));
    do
        echo "${prime[i]}"
    done
