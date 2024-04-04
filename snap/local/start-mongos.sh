#!/bin/bash

ulimit -SHf unlimited
ulimit -SHt unlimited
ulimit -SHv unlimited
ulimit -SHm unlimited
ulimit -Sl unlimited
ulimit -SHn 64000
ulimit -SHu 64000

# For security measures, daemons should not be run as sudo. Execute mongos as the non-sudo user: snap-daemon.
exec $SNAP/usr/bin/setpriv --clear-groups --reuid snap_daemon \
  --regid snap_daemon -- $SNAP/usr/bin/mongos ${MONGOS_ARGS} "$@"
