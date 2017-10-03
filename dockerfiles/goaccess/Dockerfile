FROM allinurl/goaccess:latest

ADD http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz /tmp/GeoLiteCity.dat.gz

RUN mkdir -p /usr/share/GeoIP && \
    gunzip -c /tmp/GeoLiteCity.dat.gz > /usr/share/GeoIP/GeoLiteCity.dat

ADD goaccess.conf /etc/goaccess.conf

CMD ["goaccess", "--no-global-config", "--config-file=/etc/goaccess.conf"]
