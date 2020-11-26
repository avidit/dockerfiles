FROM arm32v6/alpine:latest as builder

RUN apk add --no-cache alpine-sdk cmake git libusb-dev; \
    git clone --single-branch --progress git://git.osmocom.org/rtl-sdr.git /usr/local/rtl-sdr; \
    mkdir -vp /usr/local/rtl-sdr/build; \
    cd /usr/local/rtl-sdr/build; \
    cmake -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON ..; \
    make; \
    make install

FROM arm32v6/alpine:latest

LABEL maintainer="aabishkar@gmail.com"

COPY --from=builder /usr/local /usr/local

RUN apk add --no-cache libusb

EXPOSE 1234/tcp

ENTRYPOINT ["/usr/local/bin/rtl_tcp"]

CMD	["-a", "::"]
