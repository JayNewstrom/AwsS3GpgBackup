#!/usr/bin/with-contenv sh

if [[ "$SKIP_INITIAL_RUN" == "true" ]]; then
  echo "Skipping initial run."
else
  echo "Performing initial run."
  ./run.sh
fi
