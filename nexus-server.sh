#!/bin/bash  

#Nexus Repository Manager Installation

apt update -y
apt install -y docker.io 

docker run -d -p 8081:8081 --name nexus-server sonatype/nexus3
