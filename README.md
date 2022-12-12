# Percona MongoDB Snap
This repository contains the packaging metadata for creating a snap of Percona MongoDB built from the official percona debian repositories.  For more information on snaps, visit [snapcraft.io](https://snapcraft.io/). 

## Installing the Snap
The snap can be installed directly from the Stap Store.  Follow the link below for more information.
<br>

[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/mongodb)

## Building the Snap
### Clone Repository
```bash
git clone git@github.com:canonical/mongodb-snap.git
cd mongodb-snap
```
### Installing and Configuring Prerequisites
```bash
sudo snap install snapcraft
sudo snap install lxd
sudo lxd init --auto
```
### Packing and Installing the Snap
```bash
snapcraft pack
sudo snap install ./mongodb*.charm --devmode
```

## License
The Percona MongoDB Snap is free software, distributed under the Apache
Software License, version 2.0. See
[LICENSE](https://github.com/canonical/charmed-mongodb-snap/blob/5.0/edge/LICENSE)
for more information.
