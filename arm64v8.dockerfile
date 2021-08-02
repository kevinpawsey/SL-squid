FROM alpine AS builder

# Download QEMU, see https://github.com/docker/hub-feedback/issues/1261
ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-aarch64.tar.gz
RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . --strip-components 1

FROM arm64v8/alpine

# Add QEMU
COPY --from=builder qemu-aarch64-static /usr/bin

MAINTAINER Kevin Pawsey

ENV PROXY_UID 13
ENV PROXY_GID 13

USER root
RUN apk update && \
    apk add bash && \
    apk add python3 &&\
    apk add squid

# COPY squid.conf /etc/squid/squid.conf
COPY start-squid.sh /bin/start-squid.sh
RUN chmod +x /bin/start-squid.sh

RUN addgroup --gid 13 proxy
RUN adduser --uid 13 proxy proxy

USER proxy

VOLUME /etc/squid
VOLUME /var/log/squid
VOLUME /var/spool/squid

EXPOSE 3128/tcp
EXPOSE 3129/tcp

# CMD ["/usr/sbin/squid", "-N", "-X", "-F", "/etc/squid/squid.conf"]
CMD ["/bin/start-squid.sh"]
