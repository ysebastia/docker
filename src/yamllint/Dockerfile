FROM alpine:20220715
RUN apk add --no-cache yamllint=1.27.1-r0 \
  && addgroup -S yamllint \
  && adduser -S yamllint -G yamllint -h /yamllint
WORKDIR /yamllint
USER yamllint
CMD ["/usr/bin/yamllint"]
