#!/bin/bash
source server.config

IsServerNotActive=$(screen -ls | grep -o ".mcs")
if [ -z $IsServerNotActive ]
then
    cd $server_path
        echo 'Starting server'
        screen -dmS mcs java $server_memory_configuration -jar server.jar nogui 
        sleep $sleep_threshold

        # Espera hasta que se inicie por completo el servidor
        while [ -z $(cat $(find .. -name 'latest.log') | grep -o 'Done') ]
        do
            ServerException=$(cat $(find .. -name 'latest.log') | grep -o 'Exception stopping the server')
            if [ ! -z "$ServerException" ]
            then
                echo "Server exception: Stopping the server" >&2
                exit 1
            fi
                
            sleep $sleep_threshold
        done

        echo 'Server started'

else
    echo "Server already started"
fi

