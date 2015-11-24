#!/bin/bash
set -e

function setConfiguration() {
  KEY=$1
  VALUE=$2
  CONFIGURATION_FILE=$3
  sed -i "s/^$KEY = .*$/$KEY = $VALUE/g" $CONFIGURATION_FILE
}

CARBON_OPTS="--debug"

if [ "$1" = 'cache' ]; then

  CONFIGURATION_FILE="/etc/carbon/cache.conf"
  exec /usr/bin/carbon-cache --config=$CONFIGURATION_FILE $CARBON_OPTS start "$@"

elif [ "$1" = 'relay' ]; then

  CONFIGURATION_FILE="/etc/carbon/relay.conf"
  if [ -n "${RELAY_DESTINATIONS+1}" ]; then
    setConfiguration "DESTINATIONS" "$RELAY_DESTINATIONS" $CONFIGURATION_FILE
  fi
  exec /usr/bin/carbon-relay --config=$CONFIGURATION_FILE $CARBON_OPTS start "$@"

elif [ "$1" = 'whisper' ]; then

  exec echo "Starting Whisper Data Container..."

fi

exec "$@"