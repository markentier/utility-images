# utilities

A bunch of small utility Docker images for use in other projects

## Images

* `ghcr.io/markentier/utilities:all-in-one` - includes all of the following
* `ghcr.io/markentier/utilities:busybox` - a small self-contained shell and utility box
* `ghcr.io/markentier/utilities:magicpak` - bundles executables with their dependencies
* `ghcr.io/markentier/utilities:upx` - compresses executables, can be used with magicpak
* `ghcr.io/markentier/utilities:sccache` - caches compilation artefacts (Rust, C/C++)

## Example

```Dockerfile
FROM debian:bookworm as builder

# ...

# magicpak, upx, sccache to help with compilation and packaging
COPY --link  --from=ghcr.io/markentier/utilities:all-in-one /usr/bin/magicpak /usr/bin/magicpak
COPY --link  --from=ghcr.io/markentier/utilities:all-in-one /usr/bin/upx /usr/bin/upx
COPY --link  --from=ghcr.io/markentier/utilities:all-in-one /usr/bin/sccache /usr/bin/sccache

# use the tools

# ...

FROM scratch as production

ENV PATH=/usr/bin:/bin

COPY --from=builder /buildstage/myapp /bin/myapp
COPY --from=builder /var/empty /var/empty

# busybox shell for debugging purposes
COPY --link --from=ghcr.io/markentier/utilities:all-in-one /busybox /bin

USER 1001:1001

CMD ["/bin/myapp"]


```
