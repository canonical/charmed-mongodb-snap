#!/bin/sh
# Wrapper script for pbm-agent. The agent needs access to the PBM_MONGODB_URI environment 
# variable, but snap daemons don't have access to environment variables, so this must be loaded
# via `snapctl get`

# set the URI as an environment variable to be used by pbm CLI
export PBM_MONGODB_URI="$(snapctl get uri)"
"$SNAP/usr/bin/pbm" "$@"
