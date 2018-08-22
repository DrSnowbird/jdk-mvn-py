#!/bin/bash 

###################################################
#### ---- Change this only if want to use your own
###################################################
ORGANIZATION=openkbs

###################################################
#### ---- Container package information ----
###################################################
DOCKER_IMAGE_REPO=`echo $(basename $PWD)|tr '[:upper:]' '[:lower:]'|tr "/: " "_" `
imageTag=${1:-"${ORGANIZATION}/${DOCKER_IMAGE_REPO}"}

docker run -it --rm ${imageTag} python -c 'print("Hello World")'

docker run --rm ${imageTag} python -c 'print("Hello World")'

mkdir -p ./data
echo "print('Hello World')" > ./data/myPyScript.py

dpython3='docker run -it --rm --name jdk-mvn-py -v '$PWD'/data:/data --workdir /data '${imageTag}' python'

docker run -it --rm --name some-jdk-mvn-py -v "$PWD"/data:/data --workdir /data ${imageTag} python myPyScript.py

docker run -i --rm --workdir /data ${imageTag} python < ./data/myPyScript.py


