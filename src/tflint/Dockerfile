FROM docker.io/ysebastia/wget:1.25.0-r2 AS downloader

RUN wget -q https://raw.githubusercontent.com/terraform-linters/tflint/v0.60.0/install_linux.sh \
  && bash /tmp/install_linux.sh

FROM alpine:3.23.0
COPY --from=downloader /usr/local/bin/tflint /usr/local/bin/tflint
CMD ["/usr/local/bin/tflint"]
