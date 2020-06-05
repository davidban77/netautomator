FROM alpine:edge

RUN apk add --no-cache tini && apk upgrade --no-cache

ENTRYPOINT [ "tini", "--" ]
