FROM debian:bookworm-slim

ARG UTILITY_VERSION

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl xz-utils && \
    rm -rf /var/lib/apt/lists/* && \
    update-ca-certificates --fresh

RUN ARCH=$(arch); \
    PLATFORM=$(uname -m | sed s/aarch64/arm64/ | sed s/x86_64/amd64/); \
    URL="https://github.com/upx/upx/releases/download/v${UTILITY_VERSION}/upx-${UTILITY_VERSION}-${PLATFORM}_linux.tar.xz"; \
    echo "ARCH:     ${ARCH}"; \
    echo "PLATFORM: ${PLATFORM}"; \
    echo "URL:      ${URL}"; \
    curl -sSLo upx.tar.xz ${URL} && \
    tar -xf upx.tar.xz --directory /usr/bin --strip-components=1 $(tar -tf upx.tar.xz | grep -E 'upx$') && \
    rm upx.tar.xz
# results in executable at /usr/bin/upx

FROM scratch

COPY --from=0 /usr/bin/upx /usr/bin/upx
