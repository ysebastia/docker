FROM ysebastia/pip-venv:25.1-alpine AS builder
RUN apk add --no-cache \
  gcc=14.2.0-r5 \
  musl-dev=1.2.5-r10 \
  python3-dev=3.12.10-r0 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.8 \
  ansible-lint==25.2.1 \
  black==24.10.0 \
  jmespath==1.0.1 \
  jsonschema==4.23.0 \
  pytest==8.3.4 \
  wcmatch==10.0 \
  yamllint==1.37.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM ysebastia/python:3.12.10
COPY --from=builder /venv /venv
RUN apk add --no-cache \
  openssl=3.5.0-r0 \
  py3-openssl=25.0.0-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
