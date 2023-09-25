FROM alpine:20230901
RUN apk add --no-cache \
  bash=5.2.15-r5 \
  ca-certificates=20230506-r0 \
  curl=8.3.0-r1 \
  gzip=1.13-r0 \
  make=4.4.1-r2 \
  tar=1.35-r2 \
  unzip=6.0-r14 \
  wget=1.21.4-r0
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
WORKDIR /tmp