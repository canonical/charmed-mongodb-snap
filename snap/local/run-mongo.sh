#!/bin/sh
# Wrapper script for mongo to be run with restricted privileges
exec "${SNAP}"/usr/bin/setpriv \
        --clear-groups \
        --reuid snap_daemon \
        --regid snap_daemon -- \
        "$SNAP/usr/bin/mongo" "$@"
