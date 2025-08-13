FROM alpine:20250108
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  openssl=3.5.2-r0 \
  py3-filelock=3.18.0-r0 \
  py3-openssl=25.0.0-r0 \
  py3-pip=25.2-r0 \
  py3-virtualenv=20.31.2-r0 \
  py3-wheel=0.46.1-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==25.2 \
  && pip install --no-cache-dir \
  setuptools==80.8.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete
