ARG REGISTRY_IMAGE

FROM ${REGISTRY_IMAGE}:magicpak AS magicpak
FROM ${REGISTRY_IMAGE}:upx AS upx
FROM ${REGISTRY_IMAGE}:sccache AS sccache
FROM ${REGISTRY_IMAGE}:busybox AS busybox

FROM busybox:latest

ENV PATH=/bin:/usr/bin

COPY --link --from=magicpak /usr/bin/magicpak /usr/bin/magicpak
COPY --link --from=upx /usr/bin/upx /usr/bin/upx
COPY --link --from=sccache /usr/bin/sccache /usr/bin/sccache
COPY --link --from=busybox /busybox /busybox
