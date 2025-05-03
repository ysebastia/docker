FROM quay.io/centos/centos:stream9
ARG HTTPS_PROXY
ARG HTTP_PROXY
ENV HTTPS_PROXY=$HTTPS_PROXY
ENV HTTP_PROXY=$HTTPS_PROXY
ENV VIRTUAL_ENV=/opt/venv
ENV http_proxy=$HTTPS_PROXY
ENV https_proxy=$HTTPS_PROXY
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
# hadolint ignore=DL3041
RUN dnf update -y \
  && dnf -y install \
  epel-release \
  git \
  python3 \
  python3-pip \
  python3.12 \
  && python3.12 -m venv /opt/venv \
  && pip install --no-cache-dir --upgrade pip==25.1.1 \
  && pip install --no-cache-dir \
  setuptools==75.6.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete \
  && dnf clean all && rm -rf /tmp/* /var/tmp/*
