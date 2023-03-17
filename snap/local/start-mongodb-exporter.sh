#!/bin/bash

# For security measures, daemons should not be run as sudo. Execute mongod as the non-sudo user: 
# snap-daemon and use the configured value for the uri
exec "${SNAP}"/usr/bin/setpriv \
        --clear-groups \
        --reuid snap_daemon \
        --regid snap_daemon -- \
        "$SNAP/bin/mongodb_exporter" --mongodb.uri "$(snapctl get monitor-uri)"

