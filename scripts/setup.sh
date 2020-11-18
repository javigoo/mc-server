#!/bin/bash

# Variables de configuración
server_path='../server/'
server_files_path='../server_files/'
server_memory_configuration='-Xmx1024M -Xms1024M'
sleep_threshold='3'

# Variables globales
server_name=$(ls $server_files_path | grep '.jar')

cd $server_path

    # Obtener version del servidor 
    rm -rf *
    cp $server_files_path$server_name $server_path
    mv $server_name 'server.jar'

    # Inicializar servidor
    echo 'First server start'
    java $server_memory_configuration -jar server.jar nogui >/dev/null

    echo 'Accepting EULA'
    echo 'eula=true' > eula.txt

    echo 'Starting server to generate configuration files'
    screen -d -m -L -S mcs java $server_memory_configuration -jar server.jar nogui 

    # Finalizar servidor
    while [ true ]
    do
        IsServerActive=$(cat screenlog.0 | grep -o 'Done')
        if [ ! -z $IsServerActive ]
        then
            echo "Shutting down server"
            #screen -r mcs -X stuff 'stop'
            #screen -r mcs -X stuff "$(printf \\r)"
            break 
        fi
        sleep $sleep_threshold
    done

    # Actualizar archivos personalizados
    echo "Updating customized files"
    cp -r $server_files_path $server_path
    rm $server_name

