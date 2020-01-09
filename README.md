# AWS S3 GPG Backup

## Usage
Before running the container, you'll need to setup a GPG public key, an AWS user, and an S3 bucket. 

```shell script
docker run --rm -it \
  -v $(pwd):/data:ro \
  -v /path_to_recipient/recipient.asc:/recipient/recipient.asc:ro \
  -v ~/.aws:/root/.aws:ro \
  jaynewstrom/aws-s3-gpg-backup
```

## Build
 - Build for the current architecture only: `docker build -t aws-s3-gpg-backup .`
 - Build for multiple architectures: `docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t aws-s3-gpg-backup .`
 
## TODO
 - Document restoration/etc

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

