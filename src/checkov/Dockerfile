FROM alpine:20230901
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  py3-filelock=3.12.4-r0 \
  py3-pip=23.2.1-r0 \
  py3-setuptools-rust=1.6.0-r0 \
  py3-virtualenv=20.24.5-r0 \
  py3-wheel=0.41.2-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==23.3 \
  && pip install --no-cache-dir \
  checkov==2.5.15
CMD ["/venv/bin/checkov"]
