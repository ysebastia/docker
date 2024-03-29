FROM alpine:20230901 as builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  gcc=13.2.1_git20240309-r0 \
  musl-dev=1.2.5-r0 \
  py3-filelock=3.13.1-r0 \
  py3-pip=24.0-r0 \
  py3-virtualenv=20.25.1-r0 \
  py3-wheel=0.42.0-r0 \
  python3-dev=3.11.8-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.0 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.8 \
  ansible-lint==24.2.1 \
  black==24.2.0 \
  jmespath==1.0.1 \
  jsonschema==4.21.1 \
  pytest==8.1.1 \
  setuptools==69.2.0 \
  wcmatch==8.5.1 \
  yamllint==1.35.1 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20230901
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  curl=8.6.0-r0 \
  git=2.44.0-r0 \
  python3=3.11.8-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
