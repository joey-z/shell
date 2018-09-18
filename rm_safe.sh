#!/bin/bash 

dir=`date +"%y_%m_%d"`
dir="/home/zoe/.trash/$dir"
if [ ! -d $dir ];then
    mkdir  $dir
fi

is_f=false
args=""


function remove() {
    for j in $args; do
        if [[ -d "$j" ]] || [[ -f "$j" ]];then
            name=`basename $j`
            read -p "Remove $name?[y/n]" bool
            if [ $bool == "n" ];then
                exit
            elif [ $bool == "y" ];then
                echo $bool $name

                if [[ -d "$dir/$name" ]];then
                    echo $name  1
                    new_name="$dir/${name}_$(date '+%T')"
                    mv $j $new_name && echo "$j deleted,you can see in $new_name"
                elif [[ -f "$dir/$name" ]];then
                    mv $j $dir && echo "$j deleted,you can see in $dir"
                else
                    mv $j $dir
                fi
                
            fi
        else
            echo "error"
        fi
    done
}
while [[ $1 ]]; do
    case "$1" in
        -fr|-rf|-r|-f)
            is_f=true
            shift
            ;;
        -i)
            is_f=false
            shift
            ;;
        *)
            args="$1 $args"
            shift
            ;;
    esac
done

if [[ $is_f = ture ]];then
   mv $dir
elif [[ $is_f = false ]];then
    remove
    
fi
