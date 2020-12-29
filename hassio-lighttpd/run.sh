#!/bin/bash

PATH_WWW="/config/www"

term_handler(){
	echo "Stopping..."
	ifdown wlan0
	ip link set wlan0 down
	ip addr flush dev wlan0
	exit 0
}

# Setup signal handlers
trap 'term_handler' SIGTERM

function buildir(){
        if [[ ! -d "$PATH_WWW" ]]; then
                /bin/mkdir "$PATH_WWW"
                if [[ ! -d "$PATH_WWW" ]]; then
                        return 1
                else
                        return 0
                fi
        else
                return 0
        fi
        return 1
}

buildir
rs="$?"

if [[ ! -z $rs ]]; then
        if [ $((rs)) == 0 ]; then
                lighttpd -f /lighttpd.conf & wait ${!}
        else
                exit 1
        fi
fi