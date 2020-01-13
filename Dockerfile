FROM alpine:3.11

LABEL repository="https://github.com/untillpro-test/air-action"
LABEL homepage="https://github.com/untillpro-test/air-action"
LABEL "com.github.actions.name"="air-action"
LABEL "com.github.actions.description"="unTill Air Action"
LABEL "com.github.actions.icon"="eye"
LABEL "com.github.actions.color"="red"

RUN apk add --no-cache git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
