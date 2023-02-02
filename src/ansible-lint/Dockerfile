FROM alpine:20221110
ENV VIRTUAL_ENV=/opt/venv
RUN apk add --no-cache \
  git=2.39.1-r3 \
  py3-filelock=3.8.2-r0 \
  py3-pip=23.0-r1 \
  py3-virtualenv=20.17.1-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible \
  && python3 -m venv /opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --upgrade pip \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.7 \
  ansible-lint==6.12.0 \
  black==23.1.0 \
  jmespath==1.0.1 \
  jsonschema==4.17.3 \
  pytest==7.2.1\
  wcmatch==8.4.1 \
  yamllint==1.29.0 \
  && find /usr/lib/ -name '*.pyc' -delete \
  && ansible-galaxy collection install ansible.posix:1.5.1 \
  && ansible-galaxy collection install community.general:6.3.0
CMD ["/opt/venv/bin/ansible-lint"]
