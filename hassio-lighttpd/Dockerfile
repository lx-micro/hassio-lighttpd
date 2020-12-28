ARG BUILD_FROM
FROM $BUILD_FROM

MAINTAINER Alvaro Ramos <alvaro.ramos.soltero@gmail.com>

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV LANG C.UTF-8

# Install requirements for add-on
RUN apk update && apk add --no-cache lighttpd php7-openssl php7-sqlite3 php7-pear php7-sodium php7-common php7-xsl php7 php7-fileinfo php7-mbstring php7-dev php7-xmlreader php7-json php7-xml php7-curl php7-cgi php7-bcmath php7-dom php7 && rm -rf /var/cache/apk/*

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY mod_cgi.conf /etc/lighttpd/mod_cgi.conf
COPY php.ini /etc/php7/php.ini

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]