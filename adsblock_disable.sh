#!/bin/bash

if [[ "$EUID" = 0 ]]; then
    echo "(1) already root"
else
    sudo -k # make sure to ask for password on next sudo ✱
    if sudo true; then
        echo "(2) correct password"
    else
        echo "(3) wrong password"
        exit 1
    fi
fi

if [ ! -e "/etc/hosts_backup" ]; then
    echo "No backup file. Exiting"
    exit 1
fi

line_count=$(wc -l < /etc/hosts_backup)
if [ "$line_count" -gt 20 ]; then
    echo "backup file is too long (${line_count} lines). Probably error"
    exit 1
fi

echo "Recovering from backup /etc/hosts_backup"
sudo cp /etc/hosts_backup /etc/hosts  

line_count=$(wc -l < /etc/hosts)
echo "/etc/hosts has ${line_count} lines"


