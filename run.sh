#!/bin/sh

/bin/echo "Starting mysqlscepserver ..."

execServe="/usr/local/bin/mysqlscepserver"

# API Key - Required
if [[ ! ${API_KEY} ]]; then
  /bin/echo "No API Key Set - Exiting"
  exit 1
else
  execServe="${execServe} -api ${API_KEY}"
fi

# CA Password for ca.key
if [[ ${CAPASS} ]]; then
  execServe="${execServe} -capass ${CAPASS}"
fi

# Static challenge password (disables dynamic challenges)
if [[ ${CHALLENGE} ]]; then
  execServe="${execServe} -challenge ${CHALLENGE}"
fi

# Set debug
if [[ "${DEBUG}" = "true" ]]; then
  execServe="${execServe} -debug"
fi

# DSN - Required
if [[ ! ${DBUSER} ]] && [[ ! ${DBPASS} ]] && [[ ! ${DBNAME} ]]; then
  /bin/echo "Cannot set DSN - Exiting"
  exit 1
else
  execServe="${execServe} -dsn '${DBUSER}:${DBPASS}@tcp(${DBHOST:=127.0.0.1}:${DBPORT:=3306})/${DBNAME}'"
fi

# Port to listen on (default ":8080")
if [[ ${LISTEN} ]]; then
  execServe="${execServe} -listen ${LISTEN}"
fi

echo "Starting using: $execServe"

eval $execServe
