FROM alpine:3.17

LABEL maintainer="aabishkar@gmail.com"

RUN apk --no-cache add apache2-utils

WORKDIR /usr/ab/

ENTRYPOINT ["/usr/bin/ab"]

CMD ["-h"]
