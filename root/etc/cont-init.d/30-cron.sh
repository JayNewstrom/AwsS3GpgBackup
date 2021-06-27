#!/usr/bin/with-contenv sh

if [ -z "$CRON" ]; then
	echo "
Not running in cron mode
"
	exit 0
fi

# Set up the cron schedule.
echo "
Initializing cron
$CRON
"
CRON_USER=${CRON_USER:-"abc"}
crontab -u $CRON_USER -d # Delete any existing crontab.
echo "$CRON /usr/bin/flock -n /app/backup.lock /app/run.sh" >/tmp/crontab.tmp
crontab -u $CRON_USER /tmp/crontab.tmp
rm /tmp/crontab.tmp
