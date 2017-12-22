FROM alpine:latest

LABEL maintainer="aabishkar@gmail.com"

# https://www.victornils.net/tetris/
# vitetris is a terminal-based Tetris clone by Victor ~Nilsson~ Geraldsson.
# Gameplay is much like the early Tetris games by Nintendo.
RUN apk update \
    && apk --no-cache add build-base openssl \
    && wget -q https://github.com/vicgeralds/vitetris/archive/v0.58.0.tar.gz \
    && tar -xzf v0.58.0.tar.gz \
    && cd vitetris-0.58.0 && ./configure && make \
    && mv tetris /usr/bin/tetris \
    && rm -rf /tmp/vitetris \
    && apk del build-base openssl

ENTRYPOINT [ "/usr/bin/tetris" ]
