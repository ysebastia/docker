FROM alpine:20240807 AS builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  openssl=3.3.2-r3 \
  py3-openssl=24.1.0-r1 \
  py3-pip=24.3-r0 \
  py3-virtualenv=20.27.0-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.2 \
  && pip install --no-cache-dir --use-pep517 \
  pylint==3.2.7 \
  setuptools==72.2.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20240807
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  python3=3.12.7-r1
CMD ["/venv/bin/pylint"]
