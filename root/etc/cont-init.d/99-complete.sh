#!/usr/bin/with-contenv sh

if [ -z "${CRON}" ]; then
  echo "Skipping cron, all done."
  exit 1
fi
