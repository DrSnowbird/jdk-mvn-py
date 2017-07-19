#!/bin/bash 
mkdir ./data
cat >./data/HelloWorld.java <<-EOF
public class HelloWorld {
   public static void main(String[] args) {
      System.out.println("Hello, World");
   }
}
EOF
cat ./data/HelloWorld.java
djavac='docker run -it --rm --name some-jre-mvn-py -v '$PWD'/data:/data openkbs/jre-mvn-py javac'
djava='docker run -it --rm --name some-jre-mvn-py -v '$PWD'/data:/data openkbs/jre-mvn-py java'

#docker run -it --rm --name some-jre-mvn-py -v /home/user1/github/Java8-Maven-Python/jre-mvn-py/data:/data openkbs/jre-mvn-py javac HelloWorld.java
$djavac HelloWorld.java

#docker run -it --rm --name some-jre-mvn-py -v /home/user1/github/Java8-Maven-Python/jre-mvn-py/data:/data openkbs/jre-mvn-py java HelloWorld
$djava HelloWorld


