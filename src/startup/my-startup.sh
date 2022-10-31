#!/bin/bash
echo "running my startup"
CONTAINERS_FOLDER=/env

if [ ! -f $CONTAINERS_FOLDER/run-continers.sh ]; then
    cp run-continers.sh $CONTAINERS_FOLDER/run-continers.sh
fi

i=0
until docker ps;do
    
    echo "my startup-> waiting for docker to be up $i"
    if [ $(($i % 10)) == 0 ];then 
        kill -9 $(cat /var/run/docker.pid)
        sleep 3
        rm /var/run/docker.pid
        supervisorctl start dockerd
    fi
    sleep 10
    i=$((i+1))
done

(cd $CONTAINERS_FOLDER; bash $CONTAINERS_FOLDER/run-continers.sh)


echo "finishing my startup"