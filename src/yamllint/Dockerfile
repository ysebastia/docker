FROM ysebastia/pip-venv:25.0.1-alpine AS builder
RUN pip install --no-cache-dir \
  yamllint-junit==0.10.1 \
  yamllint==1.37.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM ysebastia/python:3.12.9
COPY --from=builder /venv /venv
CMD ["/venv/bin/yamllint"]
