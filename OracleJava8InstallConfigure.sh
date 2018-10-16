#!/bin/bash

# Download latest Java Archive
cd /opt
wget --no-cookies \
--no-check-certificate \
--header "Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz
tar xzf jdk-8u181-linux-x64.tar.gz

# Install Java 8 with Alternatives
cd /opt/jdk1.8.0_181/
alternatives --install /usr/bin/java java /opt/jdk1.8.0_181/bin/java 2

# There is 1 program that provides 'java'.
#
#   Selection    Command
# -----------------------------------------------
# *+ 1           /opt/jdk1.8.0_161/bin/java

# At this point JAVA 8 has been successfully installed on your system. We also recommend to setup javac and jar commands path using alternatives

alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_181/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_181/bin/javac 2
alternatives --set jar /opt/jdk1.8.0_181/bin/jar

# Check installed Java version
java -version

# Setup Java Environment Variables
export JAVA_HOME=/opt/jdk1.8.0_181
export JRE_HOME=/opt/jdk1.8.0_181/jre
export PATH=$PATH:/opt/jdk1.8.0_181/bin:/opt/jdk1.8.0_181/jre/bin
