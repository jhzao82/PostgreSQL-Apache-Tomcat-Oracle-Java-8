#!/bin/bash

# Create a new tomcat group
groupadd tomcat

# Create a new tomcat user
useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
# -M for creating user without home directory
# -g for member of a group
# -s for indicating shell
# -d for creating new home directory

# Download Tomcat archive
http://ftp.itu.edu.tr/Mirror/Apache/tomcat/tomcat-8/v8.5.24/bin/apache-tomcat-8.5.24.tar.gz

# First create /opt/tomcat directory and install Tomcat to this directory
mkdir /opt/tomcat
tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1

# Update permissions
cd /opt/tomcat
chgrp -R tomcat /opt/tomcat
chmod -R g+r conf
chown -R tomcat webapps/ work/ temp/ logs/

# Install systemd Unit File
