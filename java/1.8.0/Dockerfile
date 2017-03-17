# Wso2 base

FROM ubuntu:16.04
MAINTAINER Sjaak

ENV TZ=Europe/Amsterdam

# Install Java.
RUN \
  apt-get update && \
  apt-get install -y software-properties-common && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install XMLStarlet, zip, nslookup
RUN \
  apt-get update && \
  apt-get install -y xmlstarlet zip unzip dnsutils && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

