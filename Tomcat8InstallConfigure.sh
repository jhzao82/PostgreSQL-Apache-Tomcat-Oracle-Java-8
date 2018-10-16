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
wget http://ftp.itu.edu.tr/Mirror/Apache/tomcat/tomcat-9/v9.0.12/bin/apache-tomcat-9.0.12.tar.gz

# First create /opt/tomcat directory and install Tomcat to this directory
mkdir /opt/tomcat
tar xvf apache-tomcat-9*tar.gz -C /opt/tomcat --strip-components=1

# Update permissions
cd /opt/tomcat
chgrp -R tomcat /opt/tomcat
chmod -R g+r conf
chown -R tomcat webapps/ work/ temp/ logs/

# Install systemd Unit File
echo "
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/opt/jdk1.8.0_181/jre
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx512M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom -Dspring.profiles.active=production -Datar.dsn=jdbc/atar -Djdk.tls.ephemeralDHKeySize=2048'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/tomcat.service

# Start the Apache Tomcat service and set it run on system boot
systemctl daemon-reload
systemctl enable tomcat
systemctl start tomcat

# Modify firewall rules for testing Apache on web browser
firewall-cmd --zone=public --permanent --add-port=8080/tcp
firewall-cmd --reload

# Edit Tomcat Configure file
vi /opt/tomcat/conf/context.xml
# Add the lines below, in <context> scope.

# <Resource
#     name="jdbc/atar"
#     auth="Container"
#     type="javax.sql.DataSource"
#     driverClassName="org.postgresql.Driver"
#     url="jdbc:postgresql://127.0.0.1:5432/atar"
#     username="atar"
#     password="atarpass"
#     maxTotal="20"
#     maxIdle="10"
#   />
