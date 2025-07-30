#!/usr/bin/with-contenv sh

if [ ! -d /zip ]; then
  mkdir /zip
fi
chown -R "${PUID}:${PGID}" /zip

if [ ! -d /gpg ]; then
  mkdir /gpg
fi
chown -R "${PUID}:${PGID}" /gpg

chown -R "${PUID}:${PGID}" /app
