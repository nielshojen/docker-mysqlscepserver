#!/bin/sh

/bin/echo "Starting mysqlscepserver ..."

execServe="/usr/local/mysqlscepserver"



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

# Static challenge password (disables dynamic challenges)
if [[ ${DEBUG} ]]; then
  execServe="${execServe} -debug ${DEBUG}"
fi

# API Key - Required
if [[ ! ${DSN} ]]; then
  /bin/echo "No DSN Set - Exiting"
  exit 1
else
  execServe="${execServe} -dsn ${DSN}"
fi

# Port to listen on (default ":8080")
if [[ ${LISTEN} ]]; then
  execServe="${execServe} -listen ${LISTEN}"
fi

echo "Starting using: $execServe"

eval $execServe
