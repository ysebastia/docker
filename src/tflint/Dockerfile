FROM docker.io/ysebastia/wget:1.21.3-r2 as downloader
RUN apk add --no-cache \
  curl=7.86.0-r1 \
  bash=5.2.9-r0
WORKDIR /tmp
RUN wget -q https://raw.githubusercontent.com/terraform-linters/tflint/v0.42.2/install_linux.sh \
  && bash /tmp/install_linux.sh

FROM alpine:20221110
COPY --from=downloader /usr/local/bin/tflint /usr/local/bin/tflint
CMD ["/usr/local/bin/tflint"]
