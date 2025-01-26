FROM ysebastia/pip-venv:24.3.1-alpine AS builder
RUN apk add --no-cache \
  gcc=14.2.0-r5 \
  musl-dev=1.2.5-r8 \
  python3-dev=3.12.8-r1 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.8 \
  ansible-lint==25.1.0 \
  black==24.10.0 \
  jmespath==1.0.1 \
  jsonschema==4.23.0 \
  pytest==8.3.4 \
  wcmatch==10.0 \
  yamllint==1.35.1 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM ysebastia/python:3.12.8
COPY --from=builder /venv /venv
RUN apk add --no-cache \
  openssl=3.3.2-r4 \
  py3-openssl=24.3.0-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
