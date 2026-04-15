FROM archlinux:base-devel-20260308.0.497099 AS builder

ARG GOTIFY_VERSION
ARG GOTIFY_RELEASE=https://github.com/gotify/server/releases/download/v${GOTIFY_VERSION}/gotify-linux-amd64.zip

RUN pacman -Sy --noconfirm unzip >/dev/null

WORKDIR /extract/gotify
RUN curl --silent --show-error --location --output gotify.zip \
  "${GOTIFY_RELEASE}" \
  && unzip gotify.zip

FROM ghcr.io/simons-containers/distroless-glibc:2.43
ARG GOTIFY_VERSION

COPY --from=builder /extract/gotify/gotify-linux-amd64 /usr/bin/gotify

WORKDIR /var/lib/gotify
ENV HOME=/var/lib/gotify

ENTRYPOINT ["/usr/bin/gotify"]

LABEL org.opencontainers.image.title="distroless gotify"
LABEL org.opencontainers.image.description="distroless gotify"
LABEL org.opencontainers.image.version="${GOTIFY_VERSION}"
LABEL org.opencontainers.image.source="https://github.com/simons-containers/distroless-gotify"
LABEL org.opencontainers.image.volumes.config="/etc/gotify"
LABEL org.opencontainers.image.volumes.data="/var/lib/gotify"
