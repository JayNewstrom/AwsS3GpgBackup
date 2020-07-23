#!/bin/sh

if [[ "$SKIP_INITIAL_RUN" == "true" ]]; then
  echo "Skipping initial run."
else
  echo "Performing initial run."
  ./run.sh "$1"
fi

if [[ "$CRON" ]]; then
  echo "Starting cron."
  echo "$CRON /run.sh $1" > /var/spool/cron/crontabs/root
  crond -l 2 -f
else
  echo "Skipping cron, all done."
fi
