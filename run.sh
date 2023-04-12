#!/bin/sh

/bin/echo "Starting mysqlscepserver ..."

execServe="/usr/local/bin/mysqlscepserver"

# API Key - Required
if [[ ! ${SCEP_API_KEY} ]]; then
  /bin/echo "No API Key Set - Exiting"
  exit 1
fi

# DSN - Required
if [[ ! ${SCEP_DSN} ]]; then
  /bin/echo "No DSN Set - Exiting"
  exit 1
fi

eval $execServe
