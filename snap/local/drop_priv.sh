#!/bin/bash
# Wrapper script for charmed mongodb applications to be run with restricted privileges

export PBM_MONGODB_URI="$(snapctl get pbm-uri)"

if [[ $(id -u) == "0" ]]; then
    exec bash -c "cd ${SNAP} && \
        ${SNAP}/usr/bin/setpriv \
        --clear-groups \
        --reuid snap_daemon \
        --regid snap_daemon \
        -- \
        ${SNAP}/usr/bin/$*"
else
    exec bash -c "cd ${SNAP} && \
        ${SNAP}/usr/bin/$*"
fi
