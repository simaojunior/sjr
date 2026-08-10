# syntax=docker/dockerfile:1

ARG ELIXIR_VERSION=1.20.0
ARG OTP_VERSION=29.0.1
ARG DEBIAN_VERSION=trixie-20260518-slim

ARG BUILDER_IMAGE="docker.io/hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
ARG RUNNER_IMAGE="docker.io/library/debian:${DEBIAN_VERSION}"

FROM ${BUILDER_IMAGE} AS build

RUN apt-get update -y && apt-get install -y build-essential git \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN mix local.hex --force && mix local.rebar --force

ENV MIX_ENV=prod

COPY mix.exs mix.lock ./
RUN mix deps.get --only prod
COPY config config
RUN mix deps.compile

COPY priv priv
COPY lib lib
COPY assets assets

RUN mix assets.deploy
RUN mix compile
RUN mix release

FROM ${RUNNER_IMAGE} AS app

RUN apt-get update -y \
  && apt-get install -y libstdc++6 openssl libncurses6 locales ca-certificates \
  && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
ENV MIX_ENV=prod PHX_SERVER=true

WORKDIR /app
RUN chown nobody /app

COPY --from=build --chown=nobody:root /app/_build/${MIX_ENV}/rel/sjr ./

USER nobody

EXPOSE 4000

CMD ["/app/bin/sjr", "start"]
