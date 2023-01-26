FROM golang:alpine as builder

RUN apk add --no-cache git go libc-dev && \
    mkdir -p /tmp/go && \
    export GOPATH=/tmp/go && \
    go install -v github.com/bemasher/rtlamr@latest && \
    cp /tmp/go/bin/* /usr/local/bin/

FROM alpine:latest

LABEL maintainer="aabishkar@gmail.com"

COPY --from=builder /usr/local /usr/local

ENTRYPOINT ["/usr/local/bin/rtlamr"]
