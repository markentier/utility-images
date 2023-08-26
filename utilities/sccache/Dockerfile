FROM debian:bookworm-slim

ARG UTILITY_VERSION

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl && \
    rm -rf /var/lib/apt/lists/* && \
    update-ca-certificates --fresh

RUN ARCH=$(arch); \
    PLATFORM=$(uname -m | sed s/aarch64/arm64/ | sed s/x86_64/amd64/); \
    URL="https://github.com/mozilla/sccache/releases/download/v${UTILITY_VERSION}/sccache-v${UTILITY_VERSION}-${ARCH}-unknown-linux-musl.tar.gz"; \
    echo "ARCH:     ${ARCH}"; \
    echo "PLATFORM: ${PLATFORM}"; \
    echo "URL:      ${URL}"; \
    curl -sSLo sccache.tar.gz ${URL} && \
    tar -xf sccache.tar.gz --directory /usr/bin --strip-components=1 $(tar -tf sccache.tar.gz | grep -E 'sccache$') && \
    rm sccache.tar.gz
# results in executable at /usr/bin/sccache

FROM scratch

COPY --from=0 /usr/bin/sccache /usr/bin/sccache
