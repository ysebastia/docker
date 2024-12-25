FROM ysebastia/pip-venv:24.3.1-alpine AS builder
RUN pip install --no-cache-dir --use-pep517 \
  ansible-core==2.18.1 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM ysebastia/python:3.12.8
COPY --from=builder /venv /venv
RUN mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
