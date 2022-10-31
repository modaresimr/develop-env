#!/bin/bash
echo "running my startup"
CONTAINERS_FOLDER=/env

if [ ! -f $CONTAINERS_FOLDER/run-continers.sh ]; then
    cp run-continers.sh $CONTAINERS_FOLDER/run-continers.sh
fi


until docker ps;do
    echo 'my startup-> waiting for docker to be up'
    sleep 10
done
(cd $CONTAINERS_FOLDER; bash $CONTAINERS_FOLDER/run-continers.sh)


echo "finishing my startup"