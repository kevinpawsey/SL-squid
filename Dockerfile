FROM alpine

MAINTAINER Kevin Pawsey

RUN apk update && \
    apk add python
    apk add squid

COPY squid.conf /etc/squid/squid.conf

EXPOSE 3128

CMD ["/usr/sbin/squid", "-N", "-X", "-F", "/etc/squid/squid.conf"]
