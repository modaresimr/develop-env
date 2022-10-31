#!/bin/bash
echo "running my startup"
CONTAINERS_FOLDER=/env

if [ ! -f $CONTAINERS_FOLDER/run-continers.sh ]; then
    cp $STARTUPDIR/run-continers.sh $CONTAINERS_FOLDER/run-continers.sh
fi

(cd $CONTAINERS_FOLDER; bash $CONTAINERS_FOLDER/run-continers.sh)


echo "finishing my startup"