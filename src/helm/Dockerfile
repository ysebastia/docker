FROM docker.io/ysebastia/wget:1.21.4-r0-2 as downloader

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN wget -q https://get.helm.sh/helm-v3.13.1-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm

FROM alpine:20230901

RUN apk add --no-cache \
  bash=5.2.15-r6 \
  git=2.42.0-r0
COPY --from=downloader /usr/local/bin/helm /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm \
  && helm repo add "stable" "https://charts.helm.sh/stable" --force-update \
  && helm plugin install https://github.com/chartmuseum/helm-push
CMD ["bash"]
