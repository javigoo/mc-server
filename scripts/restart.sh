#!/bin/sh

echo "Restarting server"

echo "The server will restart in 1 minute"
screen -R mcs -X stuff 'say The server will restart in 1 minute\n'
sleep 60

echo "Restarting server"
screen -R mcs -X stuff 'say Restarting server\n'

sleep 1
echo "3"
screen -R mcs -X stuff 'say 3\n'

sleep 1
echo "2"
screen -R mcs -X stuff 'say 2\n'

sleep 1
echo "1"
screen -R mcs -X stuff 'say 1\n'


sleep 1
screen -R mcs -X stuff 'kick @a "Server closed, it will return in approximately 2 minutes"\n'
screen -R mcs -X stuff 'stop\n'
echo "Server closed"
sleep 10

echo "Opening server"
cd ../minecraft/ && screen -S mcs java -Xms1G -Xmx3G -d64 -jar forge-1.15.2-31.1.14.jar
