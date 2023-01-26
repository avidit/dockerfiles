FROM golang:alpine as builder

RUN apk add --no-cache --virtual build-deps alpine-sdk cmake git libusb-dev; \
    git clone --single-branch --progress git://git.osmocom.org/rtl-sdr.git /usr/local/rtl-sdr; \
    mkdir -vp /usr/local/rtl-sdr/build; \
    cd /usr/local/rtl-sdr/build; \
    cmake -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON ..; \
    make; \
    make install

RUN apk add --no-cache git go libc-dev && \
    mkdir -p /tmp/go && \
    export GOPATH=/tmp/go && \
    go install -v github.com/bemasher/rtlamr@latest && \
    cp /tmp/go/bin/* /usr/local/bin/

FROM alpine:latest

LABEL maintainer="aabishkar@gmail.com"

COPY --from=builder /usr/local /usr/local

RUN apk add --no-cache libusb mosquitto-clients jq
RUN echo "blacklist dvb_usb_rtl28xxu" >> /etc/modprobe.d/rtlsdr-blacklist.conf

COPY run.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/run.sh"]
