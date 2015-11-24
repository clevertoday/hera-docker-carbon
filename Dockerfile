FROM        ubuntu:14.04
MAINTAINER  Brice Argenson <brice@clevertoday.com>

RUN         apt-get update -y && \
            apt-get install -y graphite-carbon && \
            echo "CARBON_CACHE_ENABLED=true" > /etc/default/graphite-carbon         

VOLUME      /etc/carbon
VOLUME      /var/lib/graphite/whisper

COPY        docker-entrypoint.sh /

ENTRYPOINT  ["/docker-entrypoint.sh"]

EXPOSE      2003 2004 7002 2013 2014

CMD         ["cache"]