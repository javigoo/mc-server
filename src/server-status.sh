#!/bin/bash
source server.config


IsServerNotActive=$(screen -ls | grep -o ".mcs")
if [ -z $IsServerNotActive ]
then
    echo "Server stopped"

else
    echo "Server started"
fi


cd $server_path
    log_file=$(find .. -name 'latest.log')

    if [ ! -z $log_file ]
    then
        echo
        echo "Last messages in log:"
        tail -n 15 $log_file
    fi 