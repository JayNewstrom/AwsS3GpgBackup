#!/bin/sh

./run.sh "$1"

if [[ "$NO_CRON" == "true" ]]; then
  echo "Skipping cron, all done."
else
  echo "Starting cron."
  echo "$1" > bucket_name.txt
  crond -l 2 -f
fi
