FROM alpine:20240329 as builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  gcc=13.2.1_git20240309-r0 \
  musl-dev=1.2.5-r0 \
  openssl=3.3.0-r1 \
  py3-filelock=3.13.1-r1 \
  py3-openssl=24.1.0-r1 \
  py3-pip=24.0-r2 \
  py3-virtualenv=20.25.1-r1 \
  py3-wheel=0.42.0-r1 \
  python3-dev=3.12.3-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.0 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.8 \
  ansible-lint==24.2.2 \
  black==24.4.0 \
  jmespath==1.0.1 \
  jsonschema==4.21.1 \
  pytest==8.1.1 \
  setuptools==69.5.1 \
  wcmatch==8.5.1 \
  yamllint==1.35.1 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20240329
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  curl=8.7.1-r0 \
  git=2.44.0-r2 \
  openssl=3.3.0-r1 \
  py3-openssl=24.1.0-r1 \
  python3=3.12.3-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
