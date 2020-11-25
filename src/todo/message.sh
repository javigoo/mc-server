#!/bin/sh

echo "Sending message to the server"

#Recursos servidor
screen -R mcs -X stuff 'tellraw @a ["",{"text":"\u2263","color":"red"},{"text":" ","bold":true,"color":"red"},{"text":"Recursos del servidor","clickEvent":{"action":"open_url","value":"https://mega.nz/folder/6MUWlaDC#jdCo6NjVUpRpFdZMCJeNeA"}},{"text":" \u2263","color":"red"}]\n'
