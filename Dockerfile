FROM alpine:3.11

ENV AWSCLI_VERSION "1.16.312"

RUN apk add --update --no-cache --virtual .build-deps \
        python-dev \
        py-pip \
        build-base \
    && pip install awscli==$AWSCLI_VERSION --upgrade --user \
    && mv /root/.local/bin/* /usr/local/bin \
    && apk del .build-deps \
    && apk add --update --no-cache \
        python \
        gnupg \
        zip \
    && rm -rf /var/cache/apk/* \
    && mkdir /zip \
    && mkdir /gpg

COPY run.sh .

ENTRYPOINT ["./run.sh"]
