#!/bin/bash
source server.config

# Variables globales
server_name=$(ls $server_files_path | grep '.jar')

cd $server_path

    # Obtener version del servidor 
    rm -rf *
    cp $server_files_path$server_name $server_path
    mv $server_name 'server.jar'

    # Inicializar primer inicio del servidor
    echo 'Initializing first server start'
    java $server_memory_configuration -jar server.jar nogui >/dev/null

    # Aceptar EULA
    echo 'Accepting EULA'
    echo 'eula=true' > eula.txt

    # Iniciar servidor para generar archivos de configuración
    echo 'Starting server to generate configuration files'
    screen -dmS mcs java $server_memory_configuration -jar server.jar nogui 

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

    # Finalizar servidor
    screen -r mcs 
    screen -S mcs -X stuff 'stop'
    screen -S mcs -X stuff "$(printf \\r)"

    # Actualizar archivos de configuración personalizados
    echo "Updating customized configuration files"
    cp -r $server_files_path $server_path
    rm $server_name
