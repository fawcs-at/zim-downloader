#!/bin/bash
server_port=8888

#kill the server if it's running
pid=$(ps aux | grep kiwix-tool | grep -v grep | awk '{print $2}')
if [[ $pid ]]; then
	kill $pid
fi


echo -e "\e[93m Updating ZIM library ... \e[0m"
#update library -> scrip is in library root:
zim_files=$(ls | grep -e "\.zim$")
#add every zim-file to lib
for f in $zim_files;
do
	echo -e "\e[93mAdding file: $f to library \e[0m"
	./kiwix-tools_linux-armhf-3.1.2-5/kiwix-manage $(pwd)/library.xml add $(pwd)/$f
done


echo -e "\e[93m Updating ZIM library - finished \e[0m"


echo -e "\e[92m Starting server on port: $server_port in daemon mode\e[0m"
../kiwix-tools_linux-armhf-3.1.2-5/kiwix-serve --daemon --port $server_port --library $(pwd)/library.xml

#give the kiwix-service some time to start before we check if it's up and running
sleep 5s
#check if server is runnung 
if [[ -z $(netstat -tlpn | grep $server_port | grep kiwix) ]]
then
	echo -e "\e[91mERROR: Seems that the server is not running correctly!\e[0m"
	exit(1)
else
	echo -e "\e[92mSeems that everything is fine and the server is up & running :)\e[0m"

fi


