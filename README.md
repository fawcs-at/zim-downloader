# zim-downloader
Simple shell script to download [zim](https://download.kiwix.org/zim/) packages (used by [kiwix](https://www.kiwix.org/en/)) to make website availalbe offline (e.g. wikipedia)

The script reads the URLs of zim packages that shall be downloaded and will download them if the file hosted in the zim repository is newer than the local file.

The "./calcDownloadSize.sh" shell script can be used to estimate the total size needed to download all the files listed in "files_direct.txt" which contains all the links to the zim files.


A list of all zim-packages can be found in the official [Kiwix-Wiki](https://wiki.kiwix.org/wiki/Content_in_all_languages).
The files linked on this website will also alway point ot the most recent zim-package.

zim packgages that shall be downloaded have to be enterd in the "files_direct.txt". The # symbol can be used to comment out a line.


The Kiwix package itself to host a local server that makes the zim-packages available must be obtained form the official [Kiwix-website](https://www.kiwix.org/en/download/).

The start-script can be used to rebuild the library based on the synced ZIM files and start the server up.
By default the server will spawn on port 8888 (can be configured in the script). However - please make sure that the port is allowed on your firewall (e.g. `firewall-cmd --add-port=8888/tcp; firewall-cmd --add-port=8888/tcp --permanent;`)

### Attention:
:warning: The startscript uses the [kiwix-tools](https://github.com/kiwix/kiwix-tools) ([binaries](https://download.kiwix.org/release/kiwix-tools/)) and has the path hardcoded. That path most probably needs to be adapted to whatever is used by you!
