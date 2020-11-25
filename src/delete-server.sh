#!/bin/bash
source server.config

IsServerNotActive=$(screen -ls | grep -o ".mcs")
if [ ! -z $IsServerNotActive ]
then
    ./stop-server.sh
fi

rm -rf $server_path
mkdir $server_path
echo "Server deleted" 