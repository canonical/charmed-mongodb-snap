#!/bin/bash

export CONFIG_FILE="${SNAP_COMMON}/mongod.conf"
if [ ! -f "${CONFIG_FILE}" ]; then
        echo "configuration file does not exist."
        echo "copying default config to ${CONFIG_FILE}"
        cp -r $SNAP/etc/mongod.conf $SNAP_COMMON
fi

$SNAP/usr/bin/mongod --dbpath $SNAP_DATA