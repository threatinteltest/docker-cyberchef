FROM alpine:3.5
MAINTAINER Martijn Pepping <martijn.pepping@automiq.nl>

RUN addgroup cyberchef -S && \
    adduser cyberchef -G cyberchef -S && \
    apk update && \
    apk add nodejs curl git && \
    npm install -g grunt-cli && \
    npm install -g http-server

RUN cd /srv && \
    curl -L https://github.com/gchq/CyberChef/archive/v5.7.1.tar.gz | tar zxv && \
    cd  CyberChef-5.7.1 && \
    npm install && \
    chown -R cyberchef:cyberchef /srv/CyberChef-5.7.1 && \
    grunt prod

WORKDIR /srv/CyberChef-5.7.1/build/prod
USER cyberchef
ENTRYPOINT ["http-server", "-p", "8000"]
