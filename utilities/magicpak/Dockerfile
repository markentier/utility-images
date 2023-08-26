FROM debian:bookworm-slim

ARG UTILITY_VERSION

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl && \
    rm -rf /var/lib/apt/lists/* && \
    update-ca-certificates --fresh

RUN ARCH=$(arch); \
    PLATFORM=$(uname -m | sed s/aarch64/arm64/ | sed s/x86_64/amd64/); \
    URL="https://github.com/coord-e/magicpak/releases/download/v${UTILITY_VERSION}/magicpak-${ARCH}-unknown-linux-musl"; \
    echo "ARCH:     ${ARCH}"; \
    echo "PLATFORM: ${PLATFORM}"; \
    echo "URL:      ${URL}"; \
    curl -sSLo /usr/bin/magicpak ${URL} && \
    chmod +x /usr/bin/magicpak
# results in executable at /usr/bin/magicpak

FROM scratch

COPY --from=0 /usr/bin/magicpak /usr/bin/magicpak
