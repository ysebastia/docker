FROM alpine:20240329 as builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  gcc=13.2.1_git20240309-r0 \
  musl-dev=1.2.5-r0 \
  openssl=3.3.1-r0 \
  py3-filelock=3.13.1-r1 \
  py3-openssl=24.1.0-r1 \
  py3-pip=24.0-r2 \
  py3-virtualenv=20.26.2-r0 \
  py3-wheel=0.42.0-r1 \
  python3-dev=3.12.3-r1 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.0 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.8 \
  ansible-lint==24.6.0 \
  black==24.4.2 \
  jmespath==1.0.1 \
  jsonschema==4.22.0 \
  pytest==8.2.0 \
  setuptools==70.0.0 \
  wcmatch==8.5.2 \
  yamllint==1.35.1 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20240329
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  curl=8.8.0-r0 \
  git=2.45.2-r1 \
  openssl=3.3.1-r0 \
  py3-openssl=24.1.0-r1 \
  python3=3.12.3-r1 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
