FROM busybox:1.36.1-musl

WORKDIR /shell

RUN cd /shell; \
    cp /bin/busybox .; \
    for c in $(./busybox --list); do ln -s ./busybox ./$c; done

FROM scratch

COPY --from=0 /shell /busybox
