# Percona MongoDB Snap
This repository contains the packaging metadata for creating a snap of Percona MongoDB built from the official percona debian repositories. 

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