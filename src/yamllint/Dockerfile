FROM docker.io/ysebastia/pip-venv:25.3-alpine AS builder
RUN pip install --no-cache-dir \
  yamllint-junit==0.10.1 \
  yamllint==1.37.1 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM docker.io/ysebastia/python:3.12.10
COPY --from=builder /venv /venv
CMD ["/venv/bin/yamllint"]
