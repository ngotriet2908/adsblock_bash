# Simple adsblock with bash script
Using DNS list from https://github.com/hagezi/dns-blocklists to put in etc/hosts file. 

## Enable adsblock
To enable adsblock, run `bash adsblock_enable.sh` (will ask for password if not run as root). The default dns list is 'multi' which can be overriden by adding an argument (E.g. pro version `bash adsblock_enable.sh pro`)

Note: running the enable script with create a backup of the current hosts file which will be used for disable

## Disable adsblock
Disable adsblock, run `bash adsblock_disable.sh` (will ask for password if not run as root). This will recover the backup hosts file to hosts