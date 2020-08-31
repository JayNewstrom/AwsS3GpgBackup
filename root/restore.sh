#!/bin/sh

S3_BUCKET=${1:?"Please specify the S3 Bucket."}
FILENAME=${2:?"Please specify the file you'd like to restore."}

# Configurable Paramaters - via environment variables.
AWS_OPTIONS=${AWS_OPTIONS:-""}

# Fail Fast
set -o errexit

aws s3 cp "s3://$S3_BUCKET/$FILENAME" "/gpg/$FILENAME" $AWS_OPTIONS

ZIP_FILENAME=${FILENAME%.gpg}

gpg --output "/zip/$ZIP_FILENAME" --decrypt "/gpg/$FILENAME"

unzip "/zip/$ZIP_FILENAME" -d /restore/

rm "/gpg/$FILENAME" "/zip/$ZIP_FILENAME"
