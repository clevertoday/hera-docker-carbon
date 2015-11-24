#!/bin/bash
set -e


function setConfiguration() {
  $KEY = $1
  $VALUE = $2
  sed -i "s/$KEY = .*/$KEY = $VALUE/g" /etc/carbon/carbon.conf
}


if [ -n "${RELAY_DETINATIONS+1}" ]; then
  setConfiguration "DESTINATIONS" "$RELAY_DETINATIONS"
fi

if [ -n "${RELAY_DETINATIONS+1}" ]; then
  setConfiguration "DESTINATIONS" "$RELAY_DETINATIONS"
fi


if [ "$1" = 'cache' ]; then
  exec /usr/bin/carbon-cache --config=/etc/carbon/carbon.conf --debug start "$@"
elif [ "$1" = 'relay' ]; then
  exec /usr/bin/carbon-relay --config=/etc/carbon/carbon.conf --debug start "$@"
elif [ "$1" = 'whisper' ]; then
  exec echo "Starting Whisper Data Container..."
fi


exec "$@"