FROM ubuntu:xenial

MAINTAINER openkbs

ENV DEBIAN_FRONTEND noninteractive

##### update ubuntu
RUN apt-get update \
    && apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev \
    && apt-get install -y curl net-tools build-essential git wget unzip vim python python-setuptools python-pip python-dev python-numpy \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

###################################
#### Install Java 8
###################################
#### ---------------------------------------------------------------
#### ---- Change below when upgrading version ----
#### ---------------------------------------------------------------
## https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz
ARG JAVA_MAJOR_VERSION=${JAVA_MAJOR_VERSION:-8}
ARG JAVA_UPDATE_VERSION=${JAVA_UPDATE_VERSION:-201}
ARG JAVA_BUILD_NUMBER=${JAVA_BUILD_NUMBER:-09}
ARG JAVA_DOWNLOAD_TOKEN=${JAVA_DOWNLOAD_TOKEN:-42970487e3af4f5aa5bca3f542482c60}

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

############################
#### --- JAVA_HOME --- #####
############################
ENV JAVA_HOME=$INSTALL_DIR/java

###################################
#### Install Maven 3
###################################
ARG MAVEN_VERSION=${MAVEN_VERSION:-3.6.0}
ENV MAVEN_VERSION=${MAVEN_VERSION}
ENV MAVEN_HOME=/usr/apache-maven-${MAVEN_VERSION}
ENV PATH=${PATH}:${MAVEN_HOME}/bin
RUN curl -sL http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s ${MAVEN_HOME} /usr/maven

#### Clean up 
RUN apt-get clean

###################################
#### ---- Install Gradle ---- #####
###################################
ARG GRADLE_INSTALL_BASE=${GRADLE_INSTALL_BASE:-/opt/gradle}
ARG GRADLE_VERSION=${GRADLE_VERSION:-5.1.1}

ARG GRADLE_HOME=${GRADLE_INSTALL_BASE}/gradle-${GRADLE_VERSION}
ENV GRADLE_HOME=${GRADLE_HOME}
ARG GRADLE_PACKAGE=gradle-${GRADLE_VERSION}-bin.zip
ARG GRADLE_PACKAGE_URL=https://services.gradle.org/distributions/${GRADLE_PACKAGE}
# https://services.gradle.org/distributions/gradle-5.1.1-bin.zip
RUN mkdir -p ${GRADLE_INSTALL_BASE} && \
    cd ${GRADLE_INSTALL_BASE} && \
    wget -c ${GRADLE_PACKAGE_URL} && \
    unzip -d ${GRADLE_INSTALL_BASE} ${GRADLE_PACKAGE} && \
    ls -al ${GRADLE_HOME} && \
    ln -s ${GRADLE_HOME}/bin/gradle /usr/bin/gradle && \
    ${GRADLE_HOME}/bin/gradle -v && \
    rm -f ${GRADLE_PACKAGE}

######################################
#### ---- NodeJS from Ubuntu ---- ####
######################################
#RUN apt-get update -y && \
#    apt-get install -y git xz-utils && \
#    apt-get install -y nodejs npm && \
#    npm --version && \
#    apt-get install -y gcc g++ make

#########################################
#### ---- Node from NODESOURCES ---- ####
#########################################
# Ref: https://github.com/nodesource/distributions
ARG NODE_VERSION=${NODE_VERSION:-11}
ENV NODE_VERSION=${NODE_VERSION}
RUN apt-get update -y && \
    apt-get install -y sudo curl git xz-utils && \
    curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    apt-get install -y gcc g++ make && \
    apt-get install -y nodejs && \
    node -v && npm --version

###################################
#### define working directory. ####
###################################
RUN mkdir -p /data 

COPY ./printVersions.sh ./
COPY ./examples /data/examples

VOLUME "/data"

WORKDIR /data

#### Define default command.
CMD ["/bin/bash"]

