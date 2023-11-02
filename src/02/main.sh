#!/bin/bash

function user_info {
        echo "HOSTNAME = $HOSTNAME"
        echo "TIMEZONE = $(timedatectl | grep "zone" | awk '{print $3" "$4" "$5}' )"
        echo "USER = $(whoami)"
        echo "OS = $(uname -msr)"
        echo "DATE = $(date | awk '{print $3" "$2" "$6" "$4}')"
        echo "UPTIME = $(uptime | awk '{print $3}' | sed 's/,//' )"
	echo "UPTIME_SEC = $( awk '{print $1}' /proc/uptime )"
        echo "IP = $(ip a | grep "enp0s3$" | awk '{print $2}' | sed 's/\/24//')"
        echo "MASK = $(netstat -rn | head -4 | awk '{print $3}' | tail -n 1)"
        echo "GATEWAY = $(ip r | grep "default" | awk '{print $3}')"
        echo "RAM_TOTAL = $(cat /proc/meminfo | grep "MemTotal" | awk '{printf "%.3lf", $2/1024/1024}')"
        echo "RAM_USED = $(free | grep "Mem" | awk '{printf "%.3lf", $3/1024/1024}')"
        echo "RAM_FREE = $(free | grep "Mem" | awk '{printf "%.3lf", $4/1024/1024}')"
        echo "SPACE_ROOT = $(df | grep "/$" | awk '{printf "%.2lf", $2/1024}')"
        echo "SPACE_ROOT_USED = $(df | grep "/$" | awk '{printf "%.2lf", $3/1024}')"
        echo "SPACE_ROOT_FREE = $(df | grep "/$" | awk '{printf "%.2lf", $4/1024}')"
}

if [[ $# = 0 ]]
then
        user_info
        echo -n "Do you want save file? (Y/y)"
        read answer
        if [[ $answer = 'y' || $answer = 'Y' ]]
        then
                user_info >> $(date "+%d_%m_%Y_%H_%M_%S").status
        fi
else
        echo "ERROR, your wright parametrs"
fi
