FROM alpine:20230901 as builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  gcc=13.2.1_git20231014-r0 \
  musl-dev=1.2.4_git20230717-r5 \
  py3-filelock=3.13.1-r0 \
  py3-pip=23.3.2-r0 \
  py3-virtualenv=20.25.0-r0 \
  py3-wheel=0.42.0-r0 \
  python3-dev=3.11.7-r1 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==23.3.2 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.8 \
  ansible-lint==6.22.2 \
  black==23.12.1 \
  jmespath==1.0.1 \
  jsonschema==4.20.0 \
  pytest==7.4.4 \
  wcmatch==8.5 \
  yamllint==1.33.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20230901
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  curl=8.5.0-r1 \
  git=2.43.0-r2 \
  python3=3.11.7-r1 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
