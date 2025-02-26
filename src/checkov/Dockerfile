FROM ysebastia/pip-venv:25.0.1-alpine AS builder
RUN apk add --no-cache \
  py3-setuptools-rust=1.10.2-r0 \
  && pip install --no-cache-dir \
  checkov==3.2.377 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM ysebastia/python:3.12.9
COPY --from=builder /venv /venv
CMD ["/venv/bin/checkov"]
