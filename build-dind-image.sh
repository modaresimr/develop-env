#!/bin/bash
#docker tag kasmweb/ubuntu-focal-dind:1.11.0 ubuntu-focal-dind:develop # for amd64
docker build -t ubuntu-focal-dind:develop -f workspaces-images/dockerfile-kasm-ubuntu-focal-dind workspaces-images
