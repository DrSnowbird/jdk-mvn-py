#!/bin/bash

docker run -it --rm openkbs/jre-mvn-py python -c 'print("Hello World")'

docker run --rm openkbs/jre-mvn-py python -c 'print("Hello World")'

mkdir -p ./data
echo "print('Hello World')" > ./data/myPyScript.py

docker run -it --rm --name some-jre-mvn-py -v "$PWD"/data:/data openkbs/jre-mvn-py python myPyScript.py

docker run -i --rm openkbs/jre-mvn-py python < ./data/myPyScript.py

