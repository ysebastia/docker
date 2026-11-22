FROM docker.io/ysebastia/wget:1.25.0-r3 AS downloader
ARG TFLINT_VERSION=v0.66.0
ARG TFLINT_SHA256=22be11cadc25cd02401e94c0ccc91aa63467debb8485c2a755d98f4c0a9d1e2e
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN wget -q https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_linux_amd64.zip \
  && echo "${TFLINT_SHA256}  tflint_linux_amd64.zip" | sha256sum -c - \
  && unzip tflint_linux_amd64.zip -d /usr/local/bin \
  && chmod +x /usr/local/bin/tflint

FROM alpine:3.24.1
COPY --from=downloader /usr/local/bin/tflint /usr/local/bin/tflint
CMD ["/usr/local/bin/tflint"]
