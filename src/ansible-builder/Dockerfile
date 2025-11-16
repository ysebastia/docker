FROM docker.io/ysebastia/pip-venv:25.3-alpine AS builder
RUN pip install --no-cache-dir --use-pep517 \
  ansible-builder==3.1.1 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM docker.io/ysebastia/python:3.12.10
COPY --from=builder /venv /venv
RUN apk add --no-cache \
  bash=5.3.3-r1 \
  docker-cli=28.5.1-r0 \
  docker=28.5.1-r0 \
  openssl=3.5.4-r0 \
  py3-docker-py=7.1.0-r0 \
  py3-openssl=25.3.0-r0
CMD ["/venv/bin/ansible-builder"]
