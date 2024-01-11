FROM alpine:20230901
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  py3-filelock=3.13.1-r0 \
  py3-pip=23.3.2-r0 \
  py3-setuptools-rust=1.6.0-r1 \
  py3-virtualenv=20.25.0-r0 \
  py3-wheel=0.42.0-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==23.3.2 \
  && pip install --no-cache-dir \
  checkov==3.1.57 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete
CMD ["/venv/bin/checkov"]
