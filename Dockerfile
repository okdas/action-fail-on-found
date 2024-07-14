FROM alpine:3.18

ENV REVIEWDOG_VERSION=v0.20.1

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN apk --no-cache add git=2.40.1-r0 the_silver_searcher=2.2.0-r1

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
