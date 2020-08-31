FROM crazymax/alpine-s6:3.12

ENV AWSCLI_VERSION "1.18.103"

RUN apk add --update --no-cache --virtual .build-deps \
        python3-dev \
        py-pip \
        build-base \
    && pip --no-cache-dir install awscli==$AWSCLI_VERSION --ignore-installed --upgrade --user \
    && mv /root/.local/bin/* /usr/local/bin \
    && apk del .build-deps \
    && apk add --update --no-cache \
        python3 \
        gnupg \
        zip \
    && rm -rf /var/cache/apk/* \
    && mkdir /zip \
    && mkdir /gpg

COPY root/ /

ENTRYPOINT ["/init"]
