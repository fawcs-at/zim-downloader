# zim-downloader
Simple shell script to download [zim](https://download.kiwix.org/zim/) packages (used by [kiwix](https://www.kiwix.org/en/)) to make website availalbe offline (e.g. wikipedia)

The script reads the URLs of zim packages that shall be downloaded and will download them if the file hosted in the zim repository is newer than the local file.

The "./calcDownloadSize.sh" shell script can be used to estimate the total size needed to download all the files listed in "files_direct.txt" which contains all the links to the zim files.

