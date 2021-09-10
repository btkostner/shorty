FROM elixir:1.12-alpine as build

RUN set -xe; \
  apk add --update  --no-cache \
    ca-certificates \
    g++ \
    gcc \
    git \
    libstdc++ \
    make \
    nodejs \
    npm \
    tzdata;

RUN mkdir -p /opt/shorty
COPY . /opt/shorty

ARG MIX_ENV=prod
ARG APP_NAME=shorty

RUN set -xe; \
  cd /opt/shorty/; \
  mix local.hex --force; \
  mix local.rebar --force; \
  mix deps.get; \
  MIX_ENV=dev mix assets.deploy; \
  mix release

FROM alpine:3.13 as release

RUN set -xe; \
  apk add --update  --no-cache \
    ca-certificates \
    git \
    libstdc++ \
    ncurses-libs \
    tzdata;

RUN set -xe; \
  addgroup -g 1000 -S shorty; \
  adduser -u 1000 -S -h /shorty -s /bin/sh -G shorty shorty;

ARG APP_NAME=shorty

COPY --chown=shorty:shorty --from=build /opt/shorty/_build/prod/rel/shorty /opt/shorty

ENV \
  PATH="/usr/local/bin:$PATH" \
  MIX_APP="shorty" \
  MIX_ENV="prod" \
  SHELL="/bin/bash"

USER shorty

WORKDIR /opt/shorty

EXPOSE 8080

ENTRYPOINT ["/opt/shorty/bin/shorty"]

CMD ["start"]
