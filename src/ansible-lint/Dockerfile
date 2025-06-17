FROM docker.io/ysebastia/pip-venv:25.1.1-alpine AS builder
RUN apk add --no-cache \
  gcc=14.3.0-r4 \
  musl-dev=1.2.5-r12 \
  python3-dev=3.12.11-r0 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.8 \
  ansible-lint==25.6.0 \
  black==24.10.0 \
  jmespath==1.0.1 \
  jsonschema==4.23.0 \
  pytest==8.3.4 \
  wcmatch==10.0 \
  yamllint==1.37.1 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM docker.io/ysebastia/python:3.12.10
COPY --from=builder /venv /venv
RUN apk add --no-cache \
  openssl=3.5.0-r0 \
  py3-openssl=25.0.0-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
