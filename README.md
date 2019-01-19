# Java 8 (1.8.0_201) JDK + Maven 3.6 + Python 2.7 + PIP3 18.1 + npm 6.4.1 + node v10.15.0 + Gradle 5.1
[![](https://images.microbadger.com/badges/image/openkbs/jdk-mvn-py.svg)](https://microbadger.com/images/openkbs/jdk-mvn-py "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/jdk-mvn-py.svg)](https://microbadger.com/images/openkbs/jdk-mvn-py "Get your own version badge on microbadger.com")

# License Agreement
By using this image, you agree the Oracle Java JDK License.
This image contains [Oracle JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html). You must accept the [Oracle Binary Code License Agreement for Java SE](http://www.oracle.com/technetwork/java/javase/terms/license/index.html) to use this image.

## Components:
* java version "1.8.0_201"
  Java(TM) SE Runtime Environment (build 1.8.0_201-b09)
  Java HotSpot(TM) 64-Bit Server VM (build 25.201-b09, mixed mode)
* Apache Maven 3.6.0
* npm 6.4.1 + node v10.15.0 (from NodeSource official Node Distribution)
* Gradle 5.1
* Python 2.7.12
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy 

## Pull the image from Docker Repository

```bash
docker pull openkbs/jre-mvn-py
```

## Base the image to build add-on components

```Dockerfile
FROM openkbs/jre-mvn-py
```

## Run the image

Then, you're ready to run :
Make sure you create your work directory, e.g., /data

```bash
mkdir ./data
docker run -d --name my-jre-mvn-py -v $PWD/data:/data -i -t openkbs/jre-mvn-py
```

## Build and Run your own image

Say, you will build the image "my/jre-mvn-py".

```bash
docker build -t my/jre-mvn-py .
```

To run your own image, say, with some-jre-mvn-py:

```bash
mkdir ./data
docker run -d --name some-jre-mvn-py -v $PWD/data:/data -i -t my/jre-mvn-py
```

## Shell into the Docker instance
```bash
docker exec -it some-jre-mvn-py /bin/bash
```

## Run Python code
To run Python code 

```bash
docker run --rm openkbs/jre-mvn-py python -c 'print("Hello World")'
```
or,

```bash
docker run -i --rm openkbs/jre-mvn-py python < myPyScript.py 
```

or,

```bash
mkdir ./data
echo "print('Hello World')" > ./data/myPyScript.py
docker run -it --rm --name some-jre-mvn-py -v "$PWD"/data:/data openkbs/jre-mvn-py python myPyScript.py
```

or,

```bash
alias dpy='docker run --rm openkbs/jre-mvn-py python'
dpy -c 'print("Hello World")'
```

## Compile or Run java while no local installation needed
Remember, the default working directory, /data, inside the docker container -- treat is as "/".
So, if you create subdirectory, "./data/workspace", in the host machine and
the docker container will have it as "/data/workspace".

```java
#!/bin/bash -x
mkdir ./data
cat >./data/HelloWorld.java <<-EOF
public class HelloWorld {
   public static void main(String[] args) {
      System.out.println("Hello, World");
   }
}
EOF
cat ./data/HelloWorld.java
alias djavac='docker run -it --rm --name some-jdk-mvn-py -v '$PWD'/data:/data openkbs/jdk-mvn-py javac'
alias djava='docker run -it --rm --name some-jdk-mvn-py -v '$PWD'/data:/data openkbs/jdk-mvn-py java'

djavac HelloWorld.java
djava HelloWorld
```
And, the output:
```
Hello, World
```
Hence, the alias above, "djavac" and "djava" is your docker-based "javac" and "java" commands and
it will work the same way as your local installed Java's "javac" and "java" commands.
However, for larger complex projects, you might want to consider to use Docker-based IDE.
For example, try this docker-scala-ide:
[Scala IDE in Docker](https://github.com/stevenalexander/docker-scala-ide)

# See also similar docker-based IDE
* [openkbs/docker-atom-editor](https://hub.docker.com/r/openkbs/docker-atom-editor/)
* [openkbs/eclipse-oxygen-docker](https://hub.docker.com/r/openkbs/eclipse-oxygen-docker/)
* [openkbs/eclipse-photon-docker](https://hub.docker.com/r/openkbs/eclipse-photon-docker/)
* [openkbs/eclipse-photon-vnc-docker](https://hub.docker.com/r/openkbs/eclipse-photon-vnc-docker/)
* [openkbs/intellj-docker](https://hub.docker.com/r/openkbs/intellij-docker/)
* [openkbs/intellj-vnc-docker](https://hub.docker.com/r/openkbs/intellij-vnc-docker/)
* [openkbs/knime-vnc-docker](https://hub.docker.com/r/openkbs/knime-vnc-docker/)
* [openkbs/netbeans10-docker](https://hub.docker.com/r/openkbs/netbeans10-docker/)
* [openkbs/netbeans](https://hub.docker.com/r/openkbs/netbeans/)
* [openkbs/papyrus-sysml-docker](https://hub.docker.com/r/openkbs/papyrus-sysml-docker/)
* [openkbs/pycharm-docker](https://hub.docker.com/r/openkbs/pycharm-docker/)
* [openkbs/rapidminer-docker](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/rapidminer-docker)
* [openkbs/scala-ide-docker](https://hub.docker.com/r/openkbs/scala-ide-docker/)
* [openkbs/sublime-docker](https://hub.docker.com/r/openkbs/sublime-docker/)
* [openkbs/webstorm-docker](https://hub.docker.com/r/openkbs/webstorm-docker/)
* [openkbs/webstorm-vnc-docker](https://hub.docker.com/r/openkbs/webstorm-vnc-docker/)

# See Also - Docker-based SQL GUI
* [Sqlectron SQL GUI at openkbs/sqlectron-docker](https://hub.docker.com/r/openkbs/sqlectron-docker/)
* [Mysql-Workbench at openkbs/mysql-workbench](https://hub.docker.com/r/openkbs/mysql-workbench/)
* [PgAdmin4 for PostgreSQL at openkbs/pgadmin-docker](https://hub.docker.com/r/openkbs/pgadmin-docker/)

# Releases information
```
root@e81adccb305e:/data# /printVersions.sh 
+ echo JAVA_HOME=/usr/java
JAVA_HOME=/usr/java
+ java -version
java version "1.8.0_201"
Java(TM) SE Runtime Environment (build 1.8.0_201-b09)
Java HotSpot(TM) 64-Bit Server VM (build 25.201-b09, mixed mode)
+ mvn --version
Apache Maven 3.6.0 (97c98ec64a1fdfee7767ce5ffb20918da4f719f3; 2018-10-24T18:41:47Z)
Maven home: /usr/apache-maven-3.6.0
Java version: 1.8.0_201, vendor: Oracle Corporation, runtime: /usr/jdk1.8.0_201/jre
Default locale: en_US, platform encoding: ANSI_X3.4-1968
OS name: "linux", version: "4.15.0-43-generic", arch: "amd64", family: "unix"
+ python -V
Python 2.7.12
+ pip --version
/printVersions.sh: line 7: pip: command not found
+ gradle --version

------------------------------------------------------------
Gradle 5.1.1
------------------------------------------------------------

Build time:   2019-01-10 23:05:02 UTC
Revision:     3c9abb645fb83932c44e8610642393ad62116807

Kotlin DSL:   1.1.1
Kotlin:       1.3.11
Groovy:       2.5.4
Ant:          Apache Ant(TM) version 1.9.13 compiled on July 10 2018
JVM:          1.8.0_201 (Oracle Corporation 25.201-b09)
OS:           Linux 4.15.0-43-generic amd64

+ npm -v
6.4.1
+ node -v
v10.15.0
+ cat /etc/lsb-release /etc/os-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.3 LTS"
NAME="Ubuntu"
VERSION="16.04.3 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.3 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial
```
