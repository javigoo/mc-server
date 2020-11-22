#!/bin/bash
source server.config


IsServerNotActive=$(screen -ls | grep -o ".mcs")

if [ -z $IsServerNotActive ]
then
    echo "Server stopped"

else
    echo "Server started"
fi

echo 

cd $server_path
echo 'Last messages in log:'
tail -n 15 $(find .. -name 'latest.log')