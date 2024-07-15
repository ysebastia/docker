FROM alpine:20240329 as builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  openssl=3.3.1-r3 \
  py3-openssl=24.1.0-r1 \
  py3-pip=24.1.2-r0 \
  py3-virtualenv=20.26.2-r0 \
  py3-wheel=0.42.0-r1 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.1.2 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-core==2.17.1 \
  setuptools==70.1.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20240329
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  curl=8.8.0-r0 \
  git=2.45.2-r1 \
  python3=3.12.3-r1 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
