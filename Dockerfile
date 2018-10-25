#usage example:
#1. download the required Java tar.gz from oracle and place it to the same directory as Dockerfile. Assuming it is jdk-8u181-linux-x64.tar.gz
#2. docker build -t ubuntu-java --build-arg jdktar=jdk-8u181-linux-x64.tar.gz .

FROM ubuntu:16.04
LABEL maintainer="Dan Velush bvelush@gmail.com"
ARG jdktar

COPY ${jdktar} /tmp/

ENV JAVA_HOME=/usr/lib/java/jdk-current

RUN cd /tmp/ && \
    apt-get update && apt-get dist-upgrade -y && \
    apt-get install apt-utils ca-certificates curl net-tools iputils-ping -y --no-install-recommends && \
    mkdir -p ${JAVA_HOME} && \
    tar xf jdk-8u181-linux-x64.tar.gz -C ${JAVA_HOME} --strip-components 1 && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 1 && \
    update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/bin/javac" 1 && \
    update-alternatives --set java "${JAVA_HOME}/bin/java" && \
    update-alternatives --set javac "${JAVA_HOME}/bin/javac"
