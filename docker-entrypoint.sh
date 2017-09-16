#!/bin/bash

# Create display server foor cutycapt.
Xvfb :99 -ac -screen 0 1024x768x16 >> /var/log/xvfb.log 2>&1 &
disown -ar
export DISPLAY=:99
export DEBIAN_FRONTEND=noninteractive
export INSTALL_DIR=/usr/share/sniper
export LOOT_DIR=/usr/share/sniper/loot
export PLUGINS_DIR=/usr/share/sniper/plugins
export SNIPER_SKIP_DEPENDENCIES=true
exec "$@"