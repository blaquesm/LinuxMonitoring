#!/bin/bash

if [[ "$#" -ne 4 ]] ; then
    echo "Error, should be 4 parametrs"
    exit
fi

for number in "$@"
do
    if ! [[ $number == [1-6] ]] ; then
        echo "Error, mast be namber: 1 by 6"
        exit
    fi
done

if [[ $1 == $2 ]] || [[ $3 == $4 ]] ; then
    echo "Error, color of text and background mast be deferent"
    exit
fi

 HOSTNAME=$HOSTNAME
 TIMEZONE="$(timedatectl | grep "zone" | awk '{print $3" "$4" "$5}' )"
 USER=$(whoami)
 OS=$(uname -msr)
 DATE="$(date | awk '{print $3" "$2" "$6" "$4}')"
 UPTIME="$(uptime | awk '{print $3}' | sed 's/,//' )"
 UPTIME_SEC="$(awk '{print $1}' /proc/uptime )"
 IP="$(ip a | grep "enp0s3$" | awk '{print $2}' | sed 's/\/24//')"
 MASK="$(netstat -rn | head -4 | awk '{print $3}' | tail -n 1)"
 GATEWAY="$(ip r | grep "default" | awk '{print $3}')"
 RAM_TOTAL="$(cat /proc/meminfo | grep "MemTotal" | awk '{printf "%.3lf", $2/1024/1024}')"
 RAM_USED="$(free | grep "Mem" | awk '{printf "%.3lf", $3/1024/1024}')"
 RAM_FREE="$(free | grep "Mem" | awk '{printf "%.3lf", $4/1024/1024}')"
 SPACE_ROOT="$(df | grep "/$" | awk '{printf "%.2lf", $2/1024}')"
 SPACE_ROOT_USED="$(df | grep "/$" | awk '{printf "%.2lf", $3/1024}')"
 SPACE_ROOT_FREE="$(df | grep "/$" | awk '{printf "%.2lf", $4/1024}')"

 text_color() {
    case ${1} in
        1) echo "\033[37m";;
        2) echo "\033[31m";;
        3) echo "\033[32m";;
        4) echo "\033[34m";;
        5) echo "\033[35m";;
        6) echo "\033[30m";;
    esac
}

background_color() {
    case ${1} in
        1) echo "\033[47m";;
        2) echo "\033[41m";;
        3) echo "\033[42m";;
        4) echo "\033[44m";;
        5) echo "\033[45m";;
        6) echo "\033[40m";;
    esac
}

COLOR_OFF="\033[0m"
BACKGROUND1=$(background_color "$1")
NAME1=$(text_color "$2")
BACKGROUND2=$(background_color "$3")
NAME2=$(text_color "$4")

echo -e "${NAME1}${BACKGROUND1}HOSTNAME${COLOR_OFF}        = ${NAME2}${BACKGROUND2}${HOSTNAME}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}TIMEZONE${COLOR_OFF}        = ${NAME2}${BACKGROUND2}${TIMEZONE}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}USER${COLOR_OFF}            = ${NAME2}${BACKGROUND2}${USER}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}OS${COLOR_OFF}              = ${NAME2}${BACKGROUND2}${OS}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}DATE${COLOR_OFF}            = ${NAME2}${BACKGROUND2}${DATE}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}UPTIME${COLOR_OFF}          = ${NAME2}${BACKGROUND2}${UPTIME}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}UPTIME_SEC${COLOR_OFF}      = ${NAME2}${BACKGROUND2}${UPTIME_SEC}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}IP${COLOR_OFF}              = ${NAME2}${BACKGROUND2}${IP}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}MASK${COLOR_OFF}            = ${NAME2}${BACKGROUND2}${MASK}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}GATEWAY${COLOR_OFF}         = ${NAME2}${BACKGROUND2}${GATEWAY}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}RAM_TOTAL${COLOR_OFF}       = ${NAME2}${BACKGROUND2}${RAM_TOTAL}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}RAM_USED${COLOR_OFF}        = ${NAME2}${BACKGROUND2}${RAM_USED}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}RAM_FREE${COLOR_OFF}        = ${NAME2}${BACKGROUND2}${RAM_FREE}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}SPACE_ROOT${COLOR_OFF}      = ${NAME2}${BACKGROUND2}${SPACE_ROOT}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}SPACE_ROOT_USED${COLOR_OFF} = ${NAME2}${BACKGROUND2}${SPACE_ROOT_USED}${COLOR_OFF}"
echo -e "${NAME1}${BACKGROUND1}SPACE_ROOT_FREE${COLOR_OFF} = ${NAME2}${BACKGROUND2}${SPACE_ROOT_FREE}${COLOR_OFF}"
