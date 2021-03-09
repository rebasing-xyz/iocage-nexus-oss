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
fetch -o /home/${USER}/${BIN_NAME} https://download.sonatype.com/nexus/3/nexus-3.30.0-01-unix.tar.gz
cd /home/${USER} && tar -xzvf ${BIN_NAME}

# remove the binary to save space
rm -rfv ${BIN_NAME}

# replace the nexus.vmoptions and nexus files
fetch -o /home/${USER}/nexus-3.30.0-01/bin/nexus https://raw.githubusercontent.com/rebasing-xyz/iocage-nexus-oss/main/bin/nexus
fetch -o /home/${USER}/nexus-3.30.0-01/bin/nexus.vmoptions https://raw.githubusercontent.com/rebasing-xyz/iocage-nexus-oss/main/bin/nexus.vmoptions

echo "Applying execution permission on /home/${USER}/nexus-3.30.0-01/bin/nexus"
chmod +x /home/${USER}/nexus-3.30.0-01/bin/nexus

# update ownership on nexus home
echo "Updating user permission for ${USER} / /home/${USER}"
chown -R ${USER}:${USER} /home/${USER}

##########################################################
# Defines JAVA_HOME env
export JAVA_HOME="/usr/local/openjdk8"

##########################################################
# Prepare nexus to run as a service
mkdir -p /usr/local/etc/rc.d
ln -s /home/${USER}/nexus-3.30.0-01/bin/nexus /usr/local/etc/rc.d/
sysrc -f /etc/rc.conf nexus_enable="YES"

echo -n "Starting NexusOSS..."
service nexus start 2>/dev/null
while [ "$(fetch -s http://localhost:8081/)" != "fetch: Connection refused" ]; do sleep 1; done
echo " done"

##########################################################
# Create the PLUGIN_INFO
echo "Nexus OSS Plugin. For more info please visit https://github.com/rebasing-xyz/iocage-nexus-oss.git \n
To access the Console use the default credentials: admin/admin123 \n" >> /root/PLUGIN_INFO

##########################################################
# Yei!!
echo "Post install completed!"

