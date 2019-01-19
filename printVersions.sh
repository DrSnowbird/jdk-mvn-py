#!/bin/bash -x

echo "JAVA_HOME=$JAVA_HOME"
java -version
mvn --version
python -V
pip --version
gradle --version
npm -v
node -v
cat /etc/*-release

