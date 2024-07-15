FROM alpine:20240329
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  openssl=3.3.1-r3 \
  py3-filelock=3.13.1-r1 \
  py3-openssl=24.1.0-r1 \
  py3-pip=24.1.2-r0 \
  py3-virtualenv=20.26.3-r0 \
  py3-wheel=0.42.0-r1 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.1.2 \
  && pip install --no-cache-dir \
  setuptools==70.1.0 \
  yamllint-junit==0.10.1 \
  yamllint==1.35.1 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete
CMD ["/venv/bin/yamllint"]
