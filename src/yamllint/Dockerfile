FROM ysebastia/pip-venv:24.3.1 AS builder
RUN pip install --no-cache-dir \
  yamllint-junit==0.10.1 \
  yamllint==1.35.1 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM ysebastia/python:3.12.8
COPY --from=builder /venv /venv
CMD ["/venv/bin/yamllint"]
