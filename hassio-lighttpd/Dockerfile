ARG BUILD_FROM
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV LANG C.UTF-8

RUN apk update && apk add --no-cache lighttpd && rm -rf /var/cache/apk/*

COPY lighttpd.conf /

EXPOSE 8000
VOLUME /conf/www

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]