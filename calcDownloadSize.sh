#!/bin/bash

convert_bytes() {
	printf %s\\n $1 | numfmt --to=iec-i
}

total_size=0
for l in $(cat files_direct.txt | grep -v ^#);
do
	echo -e "URL: \e[91m$l\e[0m"
	cur_size=$(curl -sIL $l | grep -i "Content-Length" | cut -d":" -f2 | sed 's/\s//g')
	total_size=$(expr $total_size + $cur_size)
	echo -e "size: $(convert_bytes $cur_size) / total: \e[93m$(convert_bytes $total_size)\e[0m"
done


echo $(convert_bytes $total_size)

