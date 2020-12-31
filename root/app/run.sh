#!/usr/bin/with-contenv sh

S3_BUCKET=${BUCKET_NAME:?"Please specify the S3 Bucket."}

# Configurable Paramaters - via environment variables.
RECIPIENT_FILENAME=${RECIPIENT_FILENAME:-"recipient.asc"}
FILENAME_PREFIX=${FILENAME_PREFIX:-"backup-"}
DATE=${DATE:-$(date +\%Y-\%m-\%d)}
AWS_OPTIONS=${AWS_OPTIONS:-""}
export GNUPGHOME=${GNUPGHOME:-"/app/.gnupg"}
export AWS_SHARED_CREDENTIALS_FILE=${AWS_SHARED_CREDENTIALS_FILE:-"/config/.aws/credentials"}
export AWS_CONFIG_FILE=${AWS_CONFIG_FILE:-"/config/.aws/config"}

# Fail Fast
set -o errexit

ZIP_FILENAME="$FILENAME_PREFIX$DATE.zip"
GPG_FILENAME="$ZIP_FILENAME.gpg"

zip -r /zip/"$ZIP_FILENAME" /data/

gpg --output "/gpg/$GPG_FILENAME" --encrypt --recipient-file "/recipient/$RECIPIENT_FILENAME" "/zip/$ZIP_FILENAME"

echo "Starting S3 Copy"
aws s3 cp "/gpg/$GPG_FILENAME" "s3://$S3_BUCKET/$GPG_FILENAME" $AWS_OPTIONS
echo "S3 Copy Complete"

rm "/gpg/$GPG_FILENAME" "/zip/$ZIP_FILENAME"
