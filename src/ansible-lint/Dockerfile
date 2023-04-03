FROM alpine:20230329
ENV VIRTUAL_ENV=/opt/venv
RUN apk add --no-cache \
  curl=8.0.1-r1 \
  git=2.40.0-r0 \
  py3-filelock=3.8.2-r0 \
  py3-pip=23.0.1-r0 \
  py3-virtualenv=20.21.0-r0 \
  py3-wheel=0.40.0-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible \
  && python3 -m venv /opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==23.0.1 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.7 \
  ansible-lint==6.14.4 \
  black==23.1.0 \
  jmespath==1.0.1 \
  jsonschema==4.17.3 \
  pytest==7.2.2 \
  wcmatch==8.4.1 \
  yamllint==1.30.0 \
  && find /usr/lib/ -name '*.pyc' -delete
CMD ["/opt/venv/bin/ansible-lint"]
