FROM alpine:3.17

LABEL maintainer="aabishkar@gmail.com"

ARG VERSION=0.59.1

# https://www.victornils.net/tetris/
# vitetris is a terminal-based Tetris clone by Victor ~Nilsson~ Geraldsson.
# Gameplay is much like the early Tetris games by Nintendo.
RUN apk update \
    && apk --no-cache add build-base openssl \
    && wget -q https://github.com/vicgeralds/vitetris/archive/v${VERSION}.tar.gz \
    && tar -xzf v${VERSION}.tar.gz \
    && cd vitetris-${VERSION} && ./configure && make \
    && mv tetris /usr/bin/tetris \
    && rm -rf /tmp/vitetris \
    && apk del build-base openssl

ENTRYPOINT [ "/usr/bin/tetris" ]
