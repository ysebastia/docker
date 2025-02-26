FROM alpine:20240923
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  openssl=3.3.3-r0 \
  py3-filelock=3.16.1-r0 \
  py3-openssl=25.0.0-r0 \
  py3-pip=25.0.1-r0 \
  py3-virtualenv=20.29.2-r0 \
  py3-wheel=0.43.0-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==25.0.1 \
  && pip install --no-cache-dir \
  setuptools==75.6.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete
