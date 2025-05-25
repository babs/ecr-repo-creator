ARG GOLANG_VERSION="1.24"
ARG KANIKO_VERSION="v1.24.0"

FROM golang:${GOLANG_VERSION}-bookworm AS build-stage

WORKDIR /app

COPY . .

RUN set -xe \
    && CGO_ENABLED=0 go build .

FROM golang:${GOLANG_VERSION}-bookworm AS golang-am8-envsubst

RUN set -xe \
    && go install github.com/a8m/envsubst/cmd/envsubst@v1.4.2

FROM gcr.io/kaniko-project/executor:${KANIKO_VERSION}-debug AS final-stage

LABEL org.opencontainers.image.source=https://github.com/babs/ecr-repo-creator

COPY --from=ghcr.io/jqlang/jq /jq /usr/local/bin/
COPY --from=golang-am8-envsubst /go/bin/envsubst /usr/local/bin/
COPY --from=build-stage /app/ecr-repo-creator /usr/local/bin/
