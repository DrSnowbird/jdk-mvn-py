# ref: https://github.com/dockerfile/java/tree/master/oracle-java8

# use the latest LTS Ubuntu
FROM ubuntu:xenial

MAINTAINER openkbs

ENV DEBIAN_FRONTEND noninteractive

##### update ubuntu
RUN apt-get update \
    && apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev \
    && apt-get install -y curl net-tools build-essential git wget unzip vim python python-setuptools python-dev python-numpy \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#### Install Java 8
#### ---------------------------------------------------------------
#### ---- Change below when upgrading version ----
#### ---------------------------------------------------------------
ARG JAVA_MAJOR_VERSION=${JAVA_MAJOR_VERSION:-8}
ARG JAVA_UPDATE_VERSION=${JAVA_UPDATE_VERSION:-181}
ARG JAVA_BUILD_NUMBER=${JAVA_BUILD_NUMBER:-13}
ARG JAVA_DOWNLOAD_TOKEN=${JAVA_DOWNLOAD_TOKEN:-96a7b8442fe848ef90c96a2fad6ed6d1}
## http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz
## http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz

#### ---------------------------------------------------------------
#### ---- Don't change below unless you know what you are doing ----
#### ---------------------------------------------------------------
ARG UPDATE_VERSION=${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}
ARG BUILD_VERSION=b${JAVA_BUILD_NUMBER}

ENV JAVA_HOME /usr/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}
ENV PATH $PATH:$JAVA_HOME/bin
ENV INSTALL_DIR /usr
RUN curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/${UPDATE_VERSION}-${BUILD_VERSION}/${JAVA_DOWNLOAD_TOKEN}/jdk-${UPDATE_VERSION}-linux-x64.tar.gz" \
  | gunzip \
  | tar x -C $INSTALL_DIR/ \
  && ln -s $JAVA_HOME $INSTALL_DIR/java \
  && rm -rf $JAVA_HOME/man

#### Install Maven 3
ARG MAVEN_VERSION=${MAVEN_VERSION:-3.5.4}
ENV MAVEN_VERSION=${MAVEN_VERSION}
ENV MAVEN_HOME=/usr/apache-maven-${MAVEN_VERSION}
ENV PATH $PATH:${MAVEN_HOME}/bin
RUN curl -sL http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s ${MAVEN_HOME} /usr/maven

#### Clean up 
RUN apt-get clean

#### define working directory.
RUN mkdir -p /data

VOLUME "/data"

WORKDIR /data

#### Define default command.
CMD ["/bin/bash"]

