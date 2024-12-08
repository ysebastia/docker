FROM alpine:20240923 AS builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  gcc=14.2.0-r4 \
  musl-dev=1.2.5-r6 \
  openssl=3.3.2-r4 \
  py3-filelock=3.13.1-r1 \
  py3-openssl=24.1.0-r1 \
  py3-pip=24.3.1-r0 \
  py3-virtualenv=20.28.0-r0 \
  py3-wheel=0.43.0-r0 \
  python3-dev=3.12.7-r1 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.3.1 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.8 \
  ansible-lint==24.10.0 \
  black==24.10.0 \
  jmespath==1.0.1 \
  jsonschema==4.23.0 \
  pytest==8.3.3 \
  setuptools==75.5.0 \
  wcmatch==10.0 \
  yamllint==1.35.1 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20240923
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  curl=8.11.0-r2 \
  git=2.47.1-r0 \
  openssl=3.3.2-r4 \
  py3-openssl=24.1.0-r1 \
  python3=3.12.8-r1 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
