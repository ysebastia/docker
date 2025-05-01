FROM ysebastia/pip-venv:25.1-alpine AS builder
RUN pip install --no-cache-dir --use-pep517 \
  pylint==3.3.6 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM ysebastia/python:3.12.10
COPY --from=builder /venv /venv
CMD ["/venv/bin/pylint"]
