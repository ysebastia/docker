FROM ysebastia/pip-venv:24.3.1
RUN apk add --no-cache \
  py3-setuptools-rust=1.10.2-r0 \
  && pip install --no-cache-dir \
  checkov==3.2.344 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete
CMD ["/venv/bin/checkov"]
