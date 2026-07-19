FROM cgr.dev/chainguard/git:latest-dev AS fetch

ARG GOTIFY_VERSION
ARG GOTIFY_SOURCE=https://github.com/gotify/server.git/

WORKDIR /fetch
RUN git config --global advice.detachedHead false
RUN git clone --depth 1 --branch "v${GOTIFY_VERSION}" \
  "${GOTIFY_SOURCE}" gotify

FROM cgr.dev/chainguard/node:latest-dev as frontend

COPY --from=fetch --chown=node:node /fetch/gotify/ui /build/frontend
WORKDIR /build/frontend

RUN yarn install
RUN yarn build

FROM cgr.dev/chainguard/go:latest-dev as builder
ARG GOTIFY_VERSION

USER nonroot
COPY --from=fetch --chown=nonroot:nonroot /fetch/gotify /build/gotify
COPY --from=frontend /build/frontend/build /build/gotify/ui/build
WORKDIR /build/gotify

RUN go build \
    -trimpath \
    -buildmode=pie \
    -ldflags="-w -s \
      -X main.Version=${GOTIFY_VERSION} \
      -X main.BuildDate=$(date +%F-%T) \
      -X main.Commit=$(git rev-parse --verify HEAD) \
      -X main.Mode=prod" \
    -o gotify-server

FROM ghcr.io/simons-containers/distroless-glibc:2.43
ARG GOTIFY_VERSION

COPY --from=builder /build/gotify/gotify-server /usr/bin/gotify

WORKDIR /var/lib/gotify
ENV HOME=/var/lib/gotify

ENTRYPOINT ["/usr/bin/gotify"]

LABEL org.opencontainers.image.title="distroless gotify"
LABEL org.opencontainers.image.description="distroless gotify"
LABEL org.opencontainers.image.version="${GOTIFY_VERSION}"
LABEL org.opencontainers.image.source="https://github.com/simons-containers/distroless-gotify"
LABEL org.opencontainers.image.volumes.config="/etc/gotify"
LABEL org.opencontainers.image.volumes.data="/var/lib/gotify"
