FROM docker.io/ysebastia/wget:1.24.5-r0 AS downloader

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN wget -q https://get.helm.sh/helm-v3.15.3-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm

FROM alpine:20240329

RUN apk add --no-cache \
  bash=5.2.26-r0 \
  git=2.45.2-r1
COPY --from=downloader /usr/local/bin/helm /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm \
  && helm repo add "stable" "https://charts.helm.sh/stable" --force-update \
  && helm plugin install https://github.com/chartmuseum/helm-push
CMD ["bash"]
