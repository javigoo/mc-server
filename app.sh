#!/bin/bash

while [ True ]
do 
    clear
    echo "Escoge una de las siguientes opciones:"
    echo "[1] Crear servidor"
    echo "[2] Eliminar servidor"
    echo "[x] Exit"
    echo

    read option
    case $option in
    1)
        cd src
        ./setup.sh
    ;;
    2)
        echo "Eliminar servidor"
    ;;
    x)
        exit 1
    ;;
    esac

done