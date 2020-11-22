#!/bin/bash
source server.config

screen -r mcs 
screen -S mcs -X stuff 'stop'
screen -S mcs -X stuff "$(printf \\r)"

echo "Server stopped"