#!/bin/bash -x

###################################################
#### ---- Change this only if want to use your own
###################################################
ORGANIZATION=openkbs

###################################################
#### ---- Container package information ----
###################################################
DOCKER_IMAGE_REPO=`echo $(basename $PWD)|tr '[:upper:]' '[:lower:]'|tr "/: " "_" `
imageTag=${1:-"${ORGANIZATION}/${DOCKER_IMAGE_REPO}"}

mkdir -p ./data
cat >./data/HelloWorld.java <<-EOF
public class HelloWorld {
   public static void main(String[] args) {
      System.out.println("Hello, World");
   }
}
EOF
cat ./data/HelloWorld.java
djavac='docker run -it --rm --name jdk-mvn-py -v '$PWD'/data:/data --workdir /data '${imageTag}' javac'
djava='docker run -it --rm --name jdk-mvn-py -v '$PWD'/data:/data --workdir /data '${imageTag}' java'

#docker run -it --rm --name some-jdk-mvn-py -v $PWD/data:/data --workdir /data openkbs/jdk-mvn-py javac HelloWorld.java
$djavac HelloWorld.java

#docker run -it --rm --name some-jdk-mvn-py -v $PWD/data:/data --workdir /data openkbs/jdk-mvn-py java HelloWorld
$djava HelloWorld


