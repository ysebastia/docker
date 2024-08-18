FROM alpine:20240329 AS builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  openssl=3.3.1-r3 \
  py3-openssl=24.1.0-r1 \
  py3-pip=24.2-r0 \
  py3-virtualenv=20.26.3-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.2 \
  && pip install --no-cache-dir --use-pep517 \
  pylint==3.2.6 \
  setuptools==72.2.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20240329
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  python3=3.12.5-r0
CMD ["/venv/bin/pylint"]
