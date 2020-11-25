#!/bin/bash
source server.config

# Variables globales
server_name=$(ls $server_files_path | grep '.jar')
    
# Eliminar servidor
./delete-server.sh

cd $server_path

    # Obtener version del servidor 
    cp $server_files_path$server_name $server_path
    mv $server_path$server_name 'server.jar'

    # Inicializar primer inicio del servidor
    echo 'Initializing first server start'
    java $server_memory_configuration -jar server.jar nogui >/dev/null

    # Aceptar EULA
    echo 'Accepting EULA'
    echo 'eula=true' > eula.txt

cd $src_path

    # Iniciar servidor para generar archivos de configuración
    ./start-server.sh

    # Finalizar servidor
    ./stop-server.sh

# Actualizar archivos de configuración personalizados
echo "Updating customized configuration files"
cp -r $server_files_path $server_path
rm $server_path$server_name
