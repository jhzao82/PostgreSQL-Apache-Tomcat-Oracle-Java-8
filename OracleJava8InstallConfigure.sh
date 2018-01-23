#!/bin/bash

# Download latest Java Archive
cd /opt
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz"
tar xzf jdk-8u161-linux-x64.tar.gz

# Install Java 8 with Alternatives
cd /opt/jdk1.8.0_161/
alternatives --install /usr/bin/java java /opt/jdk1.8.0_161/bin/java 2

# There is 1 program that provides 'java'.
#
#   Selection    Command
# -----------------------------------------------
# *+ 1           /opt/jdk1.8.0_161/bin/java

# At this point JAVA 8 has been successfully installed on your system. We also recommend to setup javac and jar commands path using alternatives

alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_161/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_161/bin/javac 2
alternatives --set jar /opt/jdk1.8.0_161/bin/jar

# Check installed Java version
java -version

# Setup Java Environment Variables
export JAVA_HOME=/opt/jdk1.8.0_161
export JRE_HOME=/opt/jdk1.8.0_161/jre
export PATH=$PATH:/opt/jdk1.8.0_161/bin:/opt/jdk1.8.0_161/jre/bin
