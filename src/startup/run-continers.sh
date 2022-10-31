#!/bin/bash
IMAGE_FOLDERS="" #image folders to run automatically

sleep 10

for folder in $IMAGE_FOLDERS; do
    (cd $folder;docker-compose up -d)
done


