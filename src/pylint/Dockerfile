FROM alpine:20240923 AS builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  openssl=3.3.2-r4 \
  py3-openssl=24.1.0-r1 \
  py3-pip=24.3.1-r0 \
  py3-virtualenv=20.28.0-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.3.1 \
  && pip install --no-cache-dir --use-pep517 \
  pylint==3.3.1 \
  setuptools==75.5.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20240923
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  python3=3.12.8-r1
CMD ["/venv/bin/pylint"]
