#!/bin/bash

while true
do
 response=$(curl --write-out '%{http_code}' --silent --output /dev/null http://localhost:80)

 if [[ "$response" -eq 302 ]] ; then
    echo "Received HTTP 302 status code, receive password"
    docker exec gitlab cat /etc/gitlab/initial_root_password | grep Password:
    break
 else
    sleep 30
 fi
done
