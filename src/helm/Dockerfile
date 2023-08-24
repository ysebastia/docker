FROM docker.io/ysebastia/wget:1.21.4-r0 as downloader
ARG HELM_VERSION=3.12.3
WORKDIR /tmp
RUN wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm

FROM alpine:20230329
RUN apk add --no-cache \
  bash=5.2.15-r5
COPY --from=downloader /usr/local/bin/helm /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm \
  && helm repo add "stable" "https://charts.helm.sh/stable" --force-update
CMD bash
