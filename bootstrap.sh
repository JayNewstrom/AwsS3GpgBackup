#!/bin/sh

if [[ "$SKIP_INITIAL_RUN" == "true" ]]; then
  echo "Skippping initial run."
else
  echo "Performing initial run."
  ./run.sh "$1"
fi

if [[ "$NO_CRON" == "true" ]]; then
  echo "Skipping cron, all done."
else
  echo "Starting cron."
  echo "$1" > bucket_name.txt
  crond -l 2 -f
fi
