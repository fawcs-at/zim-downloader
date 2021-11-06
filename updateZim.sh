#!/bin/bash

#for l in $(cat files_direct.txt); do if [[ "${l:0:1}" != "#" ]]; then echo -e "\e[91m$l\e[0m"; else echo -e "\e[93mComment - $l\e[0m"; fi done^C
for l in $(cat files_direct.txt);
do
	if [[ "${l:0:1}" != "#" ]]; 
	then
		name=$(echo $l | sed 's/https:\/\/download.kiwix.org\/zim\///g' )
		rm -rf sha256/$name.sha2356
		wget $l.sha256 -P sha256/ --quiet

		#check if the sha value from the current file matches with the hash from the  file we downloaded
		if [[ -f $name ]];
		then
			echo -e "\e[92mFile Exists - $name; Checking sha256 sum from local viel against sha256-sum from the online file (hash locally cached in sha256-folder).\e[0m"
			#if the hash-file for the local zim file does not exist - calculate it
			if [[ -f "$name.sha256.local" ]]; then
				sha256_current_file=$(cat $name.sha256.local)
			else 
				echo -e "\e[93mcalculating sha256 for file: $name\e[0m"
				sha256_current_file=$(sha256sum $name | cut -d" " -f1)
				echo $sha256_current_file >  $name.sha256.local
			fi

			sha256_online_file=$(cat sha256/$name.sha256 | cut -d" " -f1)
			if [[ "$sha256_current_file" != "$sha256_online_file" ]];
			then
				echo -e "\e[95mSHA256 Hash does not match -> download it\e[0m"
				#rm $name
				#wget $l -o $name -q --show-progress
				curl $l -q --show-progress -o $name
				#update the sha256 file with the has from the online file
				curl $l.sha256 | cut -d" " -f1 > "$name.sha256.local"
			else 
				echo -e "\e[96mSHA256 of files matches\e[0m"
			
			fi
		else
			echo -e "\e[93mFile does not exist -> download it\e[0m"
			wget $l -o $name -q --show-progress
		fi
	else
		echo -e "\e[93mComment - $l\e[0m";
	fi
done

#cleanup files 
#remove duplicate files:
for f in $(ls | grep -e "\.zim\.[2-9]"); do rm $f; done
#delete empty files:
for f in $(ls *.zim*); do echo -e "\e[91m$f\e[0m"; if [[ $(file $f | grep empty) ]]; then rm -f $f; fi; echo "****************************************"; done
#move .1-files
for f in $(ls | grep -e \.zim\.1$); do mv $f  $(echo $f | sed 's/\.1$//g'); done


#update zim library and start server:
./startServer.st

