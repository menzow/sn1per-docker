#!/bin/bash

# Create display server foor cutycapt.
Xvfb :99 -ac -screen 0 1024x768x16 >> /var/log/xvfb.log 2>&1 &
disown -ar


exec "$@"