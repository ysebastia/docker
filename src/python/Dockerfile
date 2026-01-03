FROM alpine:3.23.0 AS base
ARG HTTPS_PROXY
ARG HTTP_PROXY
ENV http_proxy=$HTTP_PROXY
ENV https_proxy=$HTTPS_PROXY
ENV PATH="/home/ci/.local/bin:$PATH"
RUN apk add --no-cache \
  curl=8.17.0-r1 \
  git=2.52.0-r0 \
  pipx=1.8.0-r0 \
  python3=3.12.12-r0 \
  && addgroup -S ci && adduser -S ci -G ci

FROM base AS ansible
USER ci
RUN pipx install ansible-core==2.20.1 \
  && mkdir -p /home/ci/.cache /home/ci/.ansible \
  && chmod 777 /home/ci/.cache /home/ci/.ansible
CMD ["/home/ci/.local/bin/ansible"]

FROM base AS ansible-builder
RUN apk add --no-cache \
bash=5.3.3-r1 \
docker-cli=29.1.3-r0 \
docker=29.1.3-r0 \
openssl=3.5.4-r0 \
py3-docker-py=7.1.0-r0 \
py3-openssl=25.3.0-r0
USER ci
RUN pipx install ansible-builder==3.1.1
CMD ["/home/ci/.local/bin/ansible-builder"]

FROM base AS ansible-lint
RUN apk add --no-cache \
  gcc=15.2.0-r2 \
  musl-dev=1.2.5-r21 \
  openssl=3.5.4-r0 \
  py3-openssl=25.3.0-r0 \
  python3-dev=3.12.12-r0
USER ci
RUN pipx install ansible-lint==25.12.2 \
  && pipx install ansible-lint-junit==0.17.8 \
  && pipx install yamllint==1.37.1 \
  && pipx install ansible-core==2.20.1 \
  && mkdir -p /home/ci/.cache /home/ci/.ansible \
  && chmod 777 /home/ci/.cache /home/ci/.ansible
CMD ["/home/ci/.local/bin/ansible-lint"]

FROM base AS checkov
RUN apk add --no-cache \
  py3-setuptools-rust=1.12.0-r0
USER ci
RUN pipx install checkov==3.2.495
CMD ["/home/ci/.local/bin/checkov"]

FROM base AS pylint
USER ci
RUN pipx install pylint==4.0.4
CMD ["/home/ci/.local/bin/pylint"]

FROM base AS yamllint
USER ci
RUN pipx install yamllint==1.37.1 \
  && pipx install yamllint-junit==0.10.1
CMD ["/home/ci/.local/bin/yamllint"]