FROM docker.io/ysebastia/wget:1.25.0-r2 AS downloader

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN wget -q https://get.helm.sh/helm-v3.18.4-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm

FROM alpine:20250108
ARG HTTPS_PROXY
ARG HTTP_PROXY
ENV http_proxy=$HTTP_PROXY
ENV https_proxy=$HTTPS_PROXY
ENV HTTP_PROXY=$HTTP_PROXY
ENV HTTPS_PROXY=$HTTPS_PROXY

RUN apk add --no-cache \
  bash=5.3.3-r0 \
  git=2.50.1-r0 \
  wget=1.25.0-r2
COPY --from=downloader /usr/local/bin/helm /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm \
  && helm repo add "stable" "https://charts.helm.sh/stable" --force-update \
  && helm plugin install https://github.com/chartmuseum/helm-push
CMD ["bash"]
