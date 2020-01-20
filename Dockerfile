FROM alpine:3.11

RUN apk add --no-cache git go grep

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
