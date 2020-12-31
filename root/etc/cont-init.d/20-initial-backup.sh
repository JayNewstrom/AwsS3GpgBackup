#!/usr/bin/with-contenv sh

if [[ "$SKIP_INITIAL_RUN" == "true" ]]; then
  echo "Skipping initial run."
else
  echo "Performing initial run."
  exec s6-setuidgid "${PUID}:${PGID}" /usr/bin/flock -n /app/backup.lock /app/run.sh
fi
