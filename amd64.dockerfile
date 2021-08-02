FROM amd64/alpine

MAINTAINER Kevin Pawsey

USER root
RUN apk update && \
    apk add python3 &&\
    apk add squid

COPY squid.conf /etc/squid/squid.conf
COPY start-squid.sh /bin/start-squid.sh
RUN chmod +x /bin/start-squid.sh

VOLUME /etc/squid
VOLUME /var/log/squid
VOLUME /var/spool/squid

EXPOSE 3128/tcp
EXPOSE 3129/tcp

# CMD ["/usr/sbin/squid", "-N", "-X", "-F", "/etc/squid/squid.conf"]
CMD ["/bin/start-squid.sh"]
