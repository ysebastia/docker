FROM ysebastia/pip-venv:24.3.1 AS builder
RUN pip install --no-cache-dir --use-pep517 \
  pylint==3.3.3 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM ysebastia/python:3.12.8
COPY --from=builder /venv /venv
CMD ["/venv/bin/pylint"]
