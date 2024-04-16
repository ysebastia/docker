FROM docker.io/ysebastia/wget:1.24.5-r0 as downloader

RUN wget -q https://raw.githubusercontent.com/terraform-linters/tflint/v0.50.3/install_linux.sh \
  && bash /tmp/install_linux.sh

FROM alpine:20240329
COPY --from=downloader /usr/local/bin/tflint /usr/local/bin/tflint
CMD ["/usr/local/bin/tflint"]
