FROM alpine

MAINTAINER Kevin Pawsey

USER root
RUN apk update
#    apk add python && \
#    apk add squid

COPY squid.conf /etc/squid/squid.conf
COPY start-squid.sh /bin/start-squid.sh
RUN chmod +x /bin/start-squid.sh

USER proxy

EXPOSE 3128

# CMD ["/usr/sbin/squid", "-N", "-X", "-F", "/etc/squid/squid.conf"]
CMD ["/bin/start-squid.sh"]
