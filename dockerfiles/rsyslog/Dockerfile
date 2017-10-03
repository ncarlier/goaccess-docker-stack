#########################################
# Rsyslog
#########################################
FROM alpine:latest

MAINTAINER Nicolas Carlier <https://github.com/ncarlier>

# Install packages
RUN apk add --update rsyslog && rm -rf /var/cache/apk/*

# install configuration files
COPY rsyslog.conf /etc/rsyslog.conf
COPY nginx.conf /etc/rsyslog.d/nginx.conf

# Expose rsyslog port
EXPOSE 514 514/udp

VOLUME [ "/var/log" ]

ENTRYPOINT [ "rsyslogd", "-n" ]

