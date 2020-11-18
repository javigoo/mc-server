#!/bin/sh

echo "Start automatic restart"

IsServerNotActive=$(screen -ls | grep -o ".mcs")

while [ true ]
do

   if [ -z $IsServerNotActive ]
   then
      echo "Restarting server"
      cd ../minecraft/ && screen -S mcs java -Xms1G -Xmx3G -d64 -jar forge-1.15.2-31.1.14.jar
   fi

   time=$(date +"%T")
   echo $time "- Server is active"

   sleep 10

done
