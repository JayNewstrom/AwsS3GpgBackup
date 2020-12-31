FROM crazymax/alpine-s6:3.12

RUN apk add --update --no-cache \
        python3 \
        gnupg \
        zip \
        aws-cli \
    && rm -rf /var/cache/apk/*

COPY root/ /
