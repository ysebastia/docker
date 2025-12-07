FROM alpine:3.23.0
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  openssl=3.5.4-r0 \
  py3-filelock=3.18.0-r0 \
  py3-openssl=25.3.0-r0 \
  py3-pip=25.1.1-r1 \
  py3-virtualenv=20.32.0-r0 \
  py3-wheel=0.46.1-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==25.3 \
  && pip install --no-cache-dir \
  setuptools==80.8.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete
