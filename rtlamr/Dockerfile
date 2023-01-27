FROM golang:1.19-alpine3.17 as builder

RUN apk add --no-cache git go libc-dev && \
    mkdir -p /tmp/go && \
    export GOPATH=/tmp/go && \
    go install -v github.com/bemasher/rtlamr@v0.9.3 && \
    cp /tmp/go/bin/* /usr/local/bin/

FROM alpine:latest

LABEL maintainer="aabishkar@gmail.com"

COPY --from=builder /usr/local /usr/local

ENTRYPOINT ["/usr/local/bin/rtlamr"]
