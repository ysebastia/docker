FROM alpine:20240807 AS builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  gcc=14.2.0-r4 \
  musl-dev=1.2.5-r5 \
  openssl=3.3.2-r3 \
  py3-filelock=3.13.1-r1 \
  py3-openssl=24.1.0-r1 \
  py3-pip=24.3-r0 \
  py3-virtualenv=20.27.0-r0 \
  py3-wheel=0.43.0-r0 \
  python3-dev=3.12.7-r1 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.3.1 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.8 \
  ansible-lint==24.9.2 \
  black==24.10.0 \
  jmespath==1.0.1 \
  jsonschema==4.23.0 \
  pytest==8.3.3 \
  setuptools==75.3.0 \
  wcmatch==10.0 \
  yamllint==1.35.1 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20240807
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  curl=8.10.1-r0 \
  git=2.46.2-r0 \
  openssl=3.3.2-r3 \
  py3-openssl=24.1.0-r1 \
  python3=3.12.7-r1 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
