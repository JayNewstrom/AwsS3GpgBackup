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
crontab -u abc -d # Delete any existing crontab.
echo "$CRON /usr/bin/flock -n /app/backup.lock /app/run.sh" >/tmp/crontab.tmp
crontab -u abc /tmp/crontab.tmp
rm /tmp/crontab.tmp
