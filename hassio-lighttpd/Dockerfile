ARG BUILD_FROM
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV LANG C.UTF-8

RUN apk update && apk add --no-cache lighttpd && rm -rf /var/cache/apk/*

ADD lighttpd.conf /lighttpd.conf

COPY run.sh /
RUN chmod a+x /run.sh

EXPOSE 8000

CMD [ "/run.sh" ]