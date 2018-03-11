#!/bin/bash

# Make sure volumes are mounted correctly
if [[ ! -d /usr/lib/unifi/data ]]; then
    echo -e "\nError: volume '/usr/lib/unifi/data/' not mounted.\n" >&2
    exit 1
elif [[ `mount | grep '/usr/lib/unifi/data' | awk -F '(' {'print $2'} | cut -c -2` == "ro" ]]; then
    echo -e "\nError: volume '/usr/lib/unifi/data/' is readonly.\n" >&2
    exit 1
fi

# Copy default system.properties file
if [[ ! -e /usr/lib/unifi/data/system.properties ]]; then
    cp /etc/unifi/system.properties /usr/lib/unifi/data/.
fi

# Create default site folder
if [[ ! -d /usr/lib/unifi/data/sites/default ]]; then
    mkdir -p /usr/lib/unifi/data/sites/default
fi

# Copy default config.properties file
if [[ ! -e /usr/lib/unifi/data/sites/default/config.properties ]]; then
    cp /etc/unifi/config.properties /usr/lib/unifi/data/sites/default/.
fi

# Fix user and group ownerships
chown -R unifi:unifi /usr/lib/unifi/data

# Change workdir
cd /usr/lib/unifi

# Start unifi in console mode
exec gosu unifi /usr/bin/java \
    -Xmx1024m \
    -Djava.awt.headless=true \
    -jar /usr/lib/unifi/lib/ace.jar start
