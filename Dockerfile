FROM docker.io/node:6.9-alpine

RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
        ca-certificates \
        python \
 && apk add --no-cache --virtual .build-deps \
        build-base \
 && update-ca-certificates \
 && HOME=/home/node npm install -g log.io --user "node" \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

# 28778/tcp is for the UI, 28777/tcp is for messages
EXPOSE 28778 28777
USER node
CMD log.io-server

