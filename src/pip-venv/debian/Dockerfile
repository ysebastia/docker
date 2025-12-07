FROM docker.io/debian:13.2-slim
ARG HTTPS_PROXY
ARG HTTP_PROXY
ENV DEBIAN_FRONTEND=noninteractive
ENV HTTPS_PROXY=$HTTPS_PROXY
ENV HTTP_PROXY=$HTTP_PROXY
ENV VIRTUAL_ENV=/opt/venv
ENV http_proxy=$HTTP_PROXY
ENV https_proxy=$HTTPS_PROXY
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# hadolint ignore=DL3008
RUN apt-get update \
  && apt-get -y --no-install-recommends -o APT::Get::AllowUnauthenticated=true install \
  git \
  python3 \
  python3-pip \
  python3-venv \
  && python3 -m venv /opt/venv \
  && pip install --no-cache-dir --upgrade pip==25.3 \
  && pip install --no-cache-dir \
  setuptools==80.8.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoclean \
  && apt-get clean all \
  && rm -rf /var/lib/apt/lists/*