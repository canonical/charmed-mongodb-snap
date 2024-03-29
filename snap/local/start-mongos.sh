#!/bin/bash

# For security measures, daemons should not be run as sudo. Execute mongos as the non-sudo user: snap-daemon.
exec $SNAP/usr/bin/setpriv --clear-groups --reuid snap_daemon \
  --regid snap_daemon -- $SNAP/usr/bin/mongos ${MONGOS_ARGS} "$@"
  
   