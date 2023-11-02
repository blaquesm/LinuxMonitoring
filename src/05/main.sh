#!/bin/bash

re='.*/$'
check=0
if [[ $# > 1 ]]
then
	check=1
	echo "Wright only one parametr"
elif [ $# == 0 ]
then
	check=1
	echo "Wright anither roud"
elif ! [ -d $1 ]
then
	check=1
	echo "Error, it's not dirictory"
fi

if [[ $check -eq 0 && $1 =~ $re ]]
then

	START=$(date +%s.%N)
	echo "Total number of folders (including all nested ones) = $(sudo find $1 2> /dev/null -type d| wc -l)"
	echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
	sudo du $1 -h 2> /dev/null | sort -hr | sed '1d' | cat -n | head -5 | awk '{print $1" - " $3 ",\t" $2 }'
	count=$(sudo du $1 -h 2> /dev/null | sort -hr | sed '1d' | cat -n | head -5 | awk '{print $1" - " $3 ",\t" $2 }' | wc -l)
	if [[ count<5 ]]
	then
		echo " etc up to 5 "
	fi
	echo " Total number of files = $(sudo find $1 -type f | wc -l) "
	echo " Number of: "
	echo " Configuration files (with the .conf extension) = $(sudo find $1 -type f -name "*.conf" 2> /dev/null | wc -l)"
	echo " Text files = $(sudo find $1 -type f -name "*.txt" 2> /dev/null | wc -l)"
	echo " Executable files = $(sudo find $1 -executable -type f 2> /dev/null | wc -l)"
	echo " Log files (with the extension .log) = $(sudo find $1 -type f -name "*.log" 2> /dev/null | wc -l)"
	echo " Archive files = $(sudo find $1 -type f -name "*.zip" -o -name "*.7z" -o -name "*.rar" -o -name "*.tar" 2> /dev/null | wc -l)"
	echo " Symbolic links = $(sudo find $1 -type 2> /dev/null | wc -l )"
	echo " TOP 10 files of maximum size arranged in descending order (path, size and type): "
	array=($(sudo find $1 -type f -exec du -h {} + 2> /dev/null | sort -hr | head -10 | awk '{print $2 }'))
	array1=($(sudo find $1 -type f -exec du -h {} + 2> /dev/null | sort -hr | head -10 | awk '{print $1 }'))
	pink=$(sudo find $1 -type f -exec du -h {} + 2> /dev/null | sort -hr | head -10 | awk '{print $2 }'| wc -l)
	for(( i=1; i<=pink; i++ ))
	do
		j=i-1
		echo "$i - ${array[$j]},	${array1[$j]},	${array[$j]##*.}"
	done 
	echo " TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)  "
	massiv=($(sudo find $1 -executable -type f -exec du -h {} + 2> /dev/null | sort -hr | head -10 | awk '{print $2 }'))
	massiv1=($(sudo find $1 -executable -type f -exec du -h {} + 2> /dev/null | sort -hr | head -10 | awk '{print $1 }'))
	point=$(sudo find $1 -executable -type f -exec du -h {} + 2> /dev/null | sort -hr | head -10 | awk '{print $2 }'| wc -l)
	for(( a=1; a<=point; a++ ))
	do
	        b=a-1
	        echo "$a - ${massiv[$b]},        ${massiv1[$b]},  $(md5sum ${massiv[$b]} | sed -r 's/ .+//')"
	done
	echo""
	END=$(date +%s.%N)
	DIFF=`echo "$END-$START" | bc -l`
	echo Time execution of the script is $DIFF s.

elif ! [[ $1 =~ $re ]]
then
     echo "Error roud"
fi
