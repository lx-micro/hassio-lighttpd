ARG BUILD_FROM
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV LANG C.UTF-8

RUN apk update && apk add --no-cache sudo lighttpd libuser shadow && rm -rf /var/cache/apk/*

COPY lighttpd.conf /
COPY run.sh /

RUN chmod a+x /run.sh

CMD [ "/run.sh" ]