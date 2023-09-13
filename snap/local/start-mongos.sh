#!/bin/bash

# For security measures, daemons should not be run as sudo. Execute mongos as the non-sudo user: snap-daemon.
export CONFIG_SERVER_URI="$(snapctl get config-uri)"

exec $SNAP/usr/bin/setpriv --clear-groups --reuid snap_daemon \
  --regid snap_daemon -- $SNAP/usr/bin/mongos ${MONGOS_ARGS} --configdb $CONFIG_SERVER_URI "$@"
  
   