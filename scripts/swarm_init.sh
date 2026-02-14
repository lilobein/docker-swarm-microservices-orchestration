#!/bin/bash


try=0
while [ $try -lt 10 ]; do
    if [[ $# == 1 ]]; then
        TOKEN="$1"
        docker swarm join --token $TOKEN 192.168.56.10
        exit 0
    fi

    try=$((try + 1))
    sleep 2
done

echo "не получилось"
exit 1