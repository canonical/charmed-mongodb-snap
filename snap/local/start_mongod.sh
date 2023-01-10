#!/bin/bash

export CONFIG_FILE="${SNAP_COMMON}/mongod.conf"
if [ ! -f "${CONFIG_FILE}" ]; then
        echo "configuration file does not exist."
        echo "copying default config to ${CONFIG_FILE}"
        cp -r $SNAP/etc/mongod.conf $SNAP_COMMON
	mkdir -p $SNAP_COMMON/db

        chmod 770 $CONFIG_FILE
        chown snap_daemon:root $CONFIG_FILE
        chmod 770 $SNAP_COMMON/db
        chown snap_daemon:root $SNAP_COMMON/db

fi

$SNAP/usr/bin/setpriv --clear-groups --reuid snap_daemon \
  --regid snap_daemon -- $SNAP/usr/bin/mongod --config $CONFIG_FILE "$@"
