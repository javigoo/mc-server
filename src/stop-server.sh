#!/bin/bash
source server.config

IsServerNotActive=$(screen -ls | grep -o ".mcs")
if [ -z $IsServerNotActive ]
then
    echo "Server already stopped"

else
    screen -r mcs 
    screen -S mcs -X stuff 'stop'
    screen -S mcs -X stuff "$(printf \\r)"

    echo "Server stopped"
fi