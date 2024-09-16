FROM alpine:3

ENV REVIEWDOG_VERSION=v0.15.0

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN apk --no-cache add git the_silver_searcher

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
