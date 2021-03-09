#!/bin/sh
# Rebasing XYZ :: Nexus OSS TrueNAS Plugin
# 
# Post install script, this script will>
# - Download and copy the Nexus binary to its final location
# - Unpack the file and remove the tar.gz file
# - Create tne Nexus user
# - Update the ownership on /home/nexus to the nexus user
#
#
##########################################################
# Local Envs
# Default username
USER="nexus"

# Binary name
BIN_NAME="nexus-oss.tar.gz"

##########################################################
# Add nexus user
pw add user -n ${USER} -c NexusOSS -s /bin/sh -m

##########################################################
# Download and install Nexus
fetch -o /home/nexus/${BIN_NAME} https://download.sonatype.com/nexus/3/nexus-3.30.0-01-unix.tar.gz
cd /home/nexus && tar -xzvf ${BIN_NAME}

# remove the binary to save space
rm -rfv ${BIN_NAME}

# update ownership on nexus home
chown -R ${USER}:${USER} /home/nexus

##########################################################
# Defines JAVA_HOME env
export JAVA_HOME="/usr/local/openjdk8"

##########################################################
# Prepare nexus to run as a service
mkdir -p /usr/local/etc/rc.d
ln -s /home/nexus/nexus-3.30.0-01/bin/nexus /usr/local/etc/rc.d/
sysrc -f /etc/rc.conf nexus_enable="YES"

su - nexus -c 'service nexus start'

##########################################################
# Create the PLUGIN_INFO
echo "Nexus OSS Plugin. For more info please visit https://github.com/rebasing-xyz/iocage-nexus-oss.git \n
To access the Console use the default credentials: admin/admin123 \n" >> /root/PLUGIN_INFO

##########################################################
# Yei!!
echo "Post install completed!"

