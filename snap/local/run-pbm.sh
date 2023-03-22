#!/bin/sh
# Wrapper script for pbm-agent. The agent needs access to the PBM_MONGODB_URI environment 
# variable, but snap daemons don't have access to environment variables, so this must be loaded
# via `snapctl get`

# set the URI as an environment variable to be used by pbm CLI
export PBM_MONGODB_URI="$(snapctl get pbm-uri)"
exec "${SNAP}"/usr/bin/setpriv \
        --clear-groups \
        --reuid snap_daemon \
        --regid snap_daemon -- \
        "$SNAP/usr/bin/pbm" "$@"
