#!/bin/bash

PATH_WWW="/config/www"
PATH_HTDOCS="htdocs"

term_handler(){
  echo "Stopping..."
  exit 0
}

function adduser() {
  user=$(sudo /usr/bin/id lighttpd 2>&1)
  rslt=$(echo $user | awk '{ if(match($0,/unknown/)){ print 0 } else { print 1 }}')
  if [ "$rslt" == 1 ]; then
    return 1
  else
    sudo /usr/sbin/adduser --disabled-password -g lighttpd -h "$PATH_WWW/$PATH_HTDOCS" -s /sbin/nologin lighttpd
    if [ "$?" -ne 0 ]; then
      return 0
    fi
    sudo /usr/sbin/usermod -a -G lighttpd lighttpd
    if [ "$?" -ne 0 ]; then
      return 0
    fi
  fi
  usergrp=$(sudo /usr/bin/id -nG lighttpd 2>&1)
  rsltgrp=$(echo $usergrp | awk '{ if(match($0,/lighttpd/)){ print 1 } else { print 0 }}')
  if [ "$rsltgrp" == 1 ]; then
     if [[ ! -d "$PATH_WWW/$PATH_HTDOCS" ]]; then
       return 0
     else
       sudo chown -R lighttpd. "$PATH_WWW"
       if [ "$?" -ne 0 ]; then
         return 0
       else
         return 1
       fi
     fi
   else
    return 0
  fi
  return 0
}

function addgroup(){
  rsw=$(eval "getent group www-data")
  if [ -z "$rsw" ]; then
    sudo /usr/sbin/addgroup www-data
    if [ "$?" -ne 0 ]; then
       return 0
    fi
    /usr/sbin/usermod -a -G www-data lighttpd
    if [ "$?" -ne 0 ]; then
       return 0
    fi
  fi
  wwwgrp=$(sudo /usr/bin/id -nG lighttpd 2>&1)
  wwwgrp=$(echo $wwwgrp | awk '{ if(match($0,/lighttpd www-data/)){ print 1 } else { print 0 }}')
  if [ "$wwwgrp" == 1 ]; then
    return 1
   else
    return 0
  fi
  return 0
}

function buildir(){
  if [[ ! -d "$PATH_WWW/$PATH_HTDOCS" ]]; then
    if [[ ! -d "$PATH_WWW" ]]; then
      sudo /bin/mkdir "$PATH_WWW"
      if [ "$?" -ne 0 ]; then
        return 0
      fi
    fi
    if [[ ! -d "$PATH_WWW" ]]; then
      return 0
    fi
    if [[ ! -d "$PATH_WWW/$PATH_HTDOCS" ]]; then
      sudo /bin/mkdir "$PATH_WWW/$PATH_HTDOCS"
      if [ "$?" -ne 0 ]; then
        return 0
      fi
    fi
    if [[ ! -d "$PATH_WWW/$PATH_HTDOCS" ]]; then
      return 0
    else
      return 1
    fi
  else
    return 1
  fi
  return 0
}

trap 'term_handler' SIGTERM

buildir
if [[ ! "$?" == 1 ]]; then
  echo "Error: Directory not created"
  exit 1
fi

adduser
if [[ ! "$?" == 1 ]]; then
  echo "Error: User not created"
  exit 1
fi

addgroup
if [[ ! "$?" == 1 ]]; then
  echo "Error: Group not created"
  exit 1
fi

lighttpd -D -f /lighttpd.conf & wait ${!}