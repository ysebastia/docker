FROM alpine:20240329 as builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  openssl=3.3.0-r0 \
  py3-openssl=24.1.0-r1 \
  py3-pip=24.0-r2 \
  py3-virtualenv=20.25.1-r1 \
  py3-wheel=0.42.0-r1 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.0 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-core==2.16.6 \
  setuptools==69.2.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20240329
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  curl=8.7.1-r0 \
  git=2.44.0-r2 \
  python3=3.12.3-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
