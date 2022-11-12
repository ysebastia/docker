FROM alpine:20221110
RUN apk add --no-cache yamllint=1.28.0-r0 \
  && addgroup -S yamllint \
  && adduser -S yamllint -G yamllint -h /yamllint
WORKDIR /yamllint
USER yamllint
CMD ["/usr/bin/yamllint"]
