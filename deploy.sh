#!/bin/bash
docker build -t warchantua/sample-node .
docker push warchantua/sample-node

ssh -i ~/.ssh/gcp-instance-1 bogdan@35.185.237.248 << EOF 
docker pull warchantua/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi warchantua/sample-node:current || true
docker tag warchantua/sample-node:latest warchantua/sample-node:current
docker run -d --restart always --name web -p 80:80 warchantua/sample-node:current
EOF
