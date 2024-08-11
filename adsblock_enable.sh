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

version=${1:-multi}

line_count=$(wc -l < /etc/hosts)

# Check if the number of lines is greater than 20
if [ "$line_count" -gt 20 ]; then
    echo "Seem that you blocked shitty DNS already. Please run abdblock disable instead of enable"
    exit 1
fi

echo "Fetching https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/hosts/${version}.txt"
curl https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/hosts/${version}.txt -o ads_dns_list.txt
# Check if the download was successful
if [ $? -eq 0 ]; then
    sudo cp /etc/hosts /etc/hosts_backup
    echo "Created backup at /etc/hosts_backup"
    cat ads_dns_list.txt | sudo tee -a /etc/hosts > /dev/null 
    echo "Adsblock enabled"

    line_count1=$(wc -l < /etc/hosts)
    echo "Number of lines in /etc/hosts: ${line_count1}"
    rm ads_dns_list.txt
else
    echo "Failed to download the file from https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/hosts/${version}.txt"
fi



