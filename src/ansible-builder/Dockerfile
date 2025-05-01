FROM ysebastia/pip-venv:25.1-alpine AS builder
RUN pip install --no-cache-dir --use-pep517 \
  ansible-builder==3.1.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM ysebastia/python:3.12.10
COPY --from=builder /venv /venv
RUN apk add --no-cache \
  bash=5.2.37-r0 \
  docker-cli=28.0.4-r0 \
  docker=28.0.4-r0 \
  openssl=3.5.0-r0 \
  py3-docker-py=7.1.0-r0 \
  py3-openssl=25.0.0-r0
CMD ["/venv/bin/ansible-builder"]
