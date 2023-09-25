FROM docker.io/ysebastia/wget:1.21.4-r0-2 as downloader

RUN wget -q https://raw.githubusercontent.com/terraform-linters/tflint/v0.48.0/install_linux.sh \
  && bash /tmp/install_linux.sh

FROM alpine:20230901
COPY --from=downloader /usr/local/bin/tflint /usr/local/bin/tflint
CMD ["/usr/local/bin/tflint"]
