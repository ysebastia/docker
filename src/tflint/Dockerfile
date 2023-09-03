FROM docker.io/ysebastia/wget:1.21.4-r0 as downloader
RUN apk add --no-cache \
  curl=8.2.1-r0 \
  bash=5.2.15-r5
WORKDIR /tmp
RUN wget -q https://raw.githubusercontent.com/terraform-linters/tflint/v0.48.0/install_linux.sh \
  && bash /tmp/install_linux.sh

FROM alpine:20230329
COPY --from=downloader /usr/local/bin/tflint /usr/local/bin/tflint
CMD ["/usr/local/bin/tflint"]
