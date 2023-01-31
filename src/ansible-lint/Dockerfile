FROM alpine:20221110
RUN apk add --no-cache \
  git=2.39.1-r1 \
  py3-filelock=3.8.2-r0 \
  py3-pip=22.3.1-r2 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint-junit==0.17.7 \
  ansible-lint==6.11.0 \
  black==22.12.0 \
  jmespath==1.0.1 \
  jsonschema==4.17.3 \
  wcmatch==8.4.1 \
  yamllint==1.29.0 \
  && find /usr/lib/ -name '*.pyc' -delete \
  && ansible-galaxy collection install ansible.posix:1.5.1 \
  && ansible-galaxy collection install community.general:6.3.0
CMD ["/usr/bin/ansible-lint"]
