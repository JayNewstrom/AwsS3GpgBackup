# AWS S3 GPG Backup
[Dockerhub](https://hub.docker.com/r/jaynewstrom/aws-s3-gpg-backup)

This container zips, encrypts, and uploads `/data` to Amazon S3.
By default, it calls [run.sh](run.sh) when the container starts. 

## Usage
Before running the container, you'll need to setup a GPG public key, an AWS user, and an S3 bucket.

```shell script
docker run --restart=always -d --name=backup \
  -v $(pwd):/data:ro \
  -v /path_to_recipient/recipient.asc:/recipient/recipient.asc:ro \
  -v ~/.aws:/root/.aws:ro \
  -e BUCKET_NAME=your-bucket-name \
  jaynewstrom/aws-s3-gpg-backup
```

### Advanced Usage
- Bucket name may include a folder to nest within. `jaynewstrom-backup/home`
- Customize the filename with the following environment variables:
  - `FILENAME_PREFIX`
  - `DATE`
- Customize the GPG public key to read from with the `RECIPIENT_FILENAME` environment variable
- Customize the `aws s3 cp` options via the `AWS_OPTIONS` environment variable
- Skip the initial run via the environment variable `SKIP_INITIAL_RUN=true`
- Run via cron by adding an environment variable
  - `CRON=15 8 * * *`
- Backup multiple files/folders by mounting multiple volumes into the data directory
  - ```shell script
    docker run --restart=always -d --name=backup \
      -v $(pwd)/one:/data/one:ro \
      -v $(pwd)/two:/data/two:ro \
      -v $(pwd)/three:/data/three:ro \
      -v /path_to_recipient/recipient.asc:/recipient/recipient.asc:ro \
      -v ~/.aws:/root/.aws:ro \
      -e BUCKET_NAME=your-bucket-name \
      jaynewstrom/aws-s3-gpg-backup your-bucket-name
    ```

## Restore
In order to restore, first mount the private key into the container. The files will be restored into the restore volume.

```shell script
docker run --rm -it --name=restore \
  -v $(pwd):/restore \
  -v ~/.aws:/root/.aws:ro \
  --entrypoint "./restore.sh" \
  -e BUCKET_NAME=your-bucket-name \
  jaynewstrom/aws-s3-gpg-backup file-to-restore.zip.gpg
```

## Build
 - Build for the current architecture only: `docker build -t jaynewstrom/aws-s3-gpg-backup .`
 - Build for multiple architectures: `docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t jaynewstrom/aws-s3-gpg-backup . --push`

## License

    Copyright 2020 Jay Newstrom

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
