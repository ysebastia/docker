FROM docker.io/ysebastia/pip-venv:25.3-alpine AS builder
RUN apk add --no-cache \
  py3-setuptools-rust=1.12.0-r0 \
  && pip install --no-cache-dir \
  checkov==3.2.495 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM docker.io/ysebastia/python:3.12.10
COPY --from=builder /venv /venv
CMD ["/venv/bin/checkov"]
