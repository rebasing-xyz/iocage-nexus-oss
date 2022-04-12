#!/bin/sh

USER="nexus"
NEXUS_VERSION="3.38.1-01"

. /etc/rc.subr

name=nexus
rcvar=nexus_enable

start_cmd="${name}_start"
stop_cmd=":"

load_rc_config $name

nexus_start() {
    /home/${USER}/nexus-${NEXUS_VERSION}/bin/nexus start
}
nexus_stop() {
    /home/${USER}/nexus-${NEXUS_VERSION}/bin/nexus stop
}

run_rc_command "$1"