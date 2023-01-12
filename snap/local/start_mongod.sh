#!/bin/bash

export CONFIG_FILE="${SNAP_COMMON}/mongod.conf"
if [ ! -f "${CONFIG_FILE}" ]; then
        echo "configuration file does not exist."
        echo "copying default config to ${CONFIG_FILE}"
        cp -r $SNAP/etc/mongod.conf $SNAP_COMMON
	mkdir -p $SNAP_COMMON/db
	touch $SNAP_DATA/mongod.log

	# Change ownership of snap directories to allow snap_daemon to read/write
        chown -R snap_daemon:root $SNAP_DATA
        chown -R snap_daemon:root $SNAP_COMMON
fi

# For security measures, daemons should not be run as sudo. Execute mongod as the non-sudo user: snap-daemon.
$SNAP/usr/bin/setpriv --clear-groups --reuid snap_daemon \
  --regid snap_daemon -- $SNAP/usr/bin/mongod --config $CONFIG_FILE "$@"
