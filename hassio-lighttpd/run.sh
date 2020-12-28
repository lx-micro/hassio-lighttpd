#!/bin/bash

PATH_HTML="/config/www/htdocs"
PATH_WWW="/config/www"

function buildir(){
        if [[ ! -d "$PATH_WWW" ]]; then
                /bin/mkdir "$PATH_WWW"
        fi
        if [[ ! -d "$PATH_WWW" ]]; then
                return 1
        else
                if [[ ! -d "$PATH_HTML" ]]; then
                        /bin/mkdir "$PATH_HTML"
                fi
        fi
        if [[ ! -d "$PATH_HTML" ]]; then
                return 1
        fi
        if [[ ! -d "$PATH_HTML" ]] || [[ ! -d "$PATH_WWW" ]]; then
                return 1
        else
                return 0
        fi
}

buildir
rs="$?"

if [[ ! -z $rs ]]; then
        if [ $((rs)) == 0 ]; then
                echo "existe"
        else
                echo "no existe"
        fi
fi
