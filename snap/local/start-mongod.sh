#!/bin/bash

# For security measures, daemons should not be run as sudo. Execute mongod as the non-sudo user: snap-daemon.
exec $SNAP/usr/bin/setpriv --clear-groups --reuid snap_daemon \
  --regid snap_daemon -- $SNAP/usr/bin/mongod --config ${SNAP_COMMON}/mongod.conf "$@"
