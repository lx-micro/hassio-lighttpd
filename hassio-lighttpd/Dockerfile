ARG BUILD_FROM
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV LANG C.UTF-8

RUN apk update && apk add --no-cache sudo \
    lighttpd \
    shadow \
    php7 \
    php7-common \
    php7-sqlite3 \
    php7-pdo_mysql \
    php7-fileinfo \
    php7-mbstring \
    php7-dev \
    php7-xmlreader \
    php7-json \
    php7-xml \
    php7-phar \
    php7-zip \
    php7-cgi \
    php7-tidy \
    php7-dom \
    php7-ftp \
    php7-bz2 \
    php7-mysqli \
    php7-simplexml \
    php7-xmlwriter \
    && rm -rf /var/cache/apk/*

COPY lighttpd.conf /
COPY run.sh /

RUN chmod a+x /run.sh

CMD [ "/run.sh" ]