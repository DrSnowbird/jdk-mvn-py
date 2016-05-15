#!/bin/bash -x

# Reference: https://docs.docker.com/engine/userguide/containers/dockerimages/

echo "Usage: "
echo "  ${0} <repo-name/repo-tag>"
echo
imageTag=${1:-openkbs/jre-mvn-py}

docker ps -a

containerID=`docker ps |grep "${imageTag}"|awk '{print $1}'`
echo "containerID=$containerID"

echo docker commit -m "initial image" ${containerID} ${imageTag}

echo docker push ${imageTag}

