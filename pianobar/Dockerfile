FROM alpine:latest

LABEL maintainer="aabishkar@gmail.com"

RUN apk add --update openssl pianobar

RUN adduser -S piano

RUN mkdir -p /home/piano/.config/pianobar
COPY config /home/piano/.config/pianobar/config

COPY tls_fingerprint.sh /bin/tls_fingerprint.sh
RUN chmod a+x /bin/tls_fingerprint.sh

RUN echo "tls_fingerprint = `tls_fingerprint.sh`" >> /home/piano/.config/pianobar/config

ENTRYPOINT ["pianobar"]
