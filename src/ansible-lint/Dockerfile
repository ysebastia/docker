FROM alpine:20230901 as builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  gcc=13.1.1_git20230722-r2 \
  musl-dev=1.2.4_git20230717-r2 \
  py3-filelock=3.12.4-r0 \
  py3-pip=23.2.1-r0 \
  py3-virtualenv=20.24.5-r0 \
  py3-wheel=0.41.2-r0 \
  python3-dev=3.11.5-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==23.2.1 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.7 \
  ansible-lint==6.20.2 \
  black==23.3.0 \
  jmespath==1.0.1 \
  jsonschema==4.17.3 \
  pytest==7.3.1 \
  wcmatch==8.4.1 \
  yamllint==1.32.0 \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20230901
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  curl=8.3.0-r1 \
  git=2.42.0-r0 \
  python3=3.11.5-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
