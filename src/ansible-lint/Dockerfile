FROM docker.io/ysebastia/pip-venv:25.2-alpine AS builder
RUN apk add --no-cache \
  gcc=15.2.0-r0 \
  musl-dev=1.2.5-r20 \
  python3-dev=3.12.12-r0 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.8 \
  ansible-lint==25.9.2 \
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
  openssl=3.5.4-r0 \
  py3-openssl=25.0.0-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
