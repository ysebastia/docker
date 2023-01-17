FROM alpine:20221110
RUN apk add --no-cache \
  git=2.39.1-r0 \
  py3-filelock=3.8.2-r0 \
  py3-pip=22.3.1-r2 \
  yamllint=1.28.0-r1 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible \
  && pip install --no-cache-dir --use-pep517 \
  ansible-lint==6.11.0 \
  black==22.10.0 \
  jsonschema==4.17.1 \
  wcmatch==8.4.1 \
  && find /usr/lib/ -name '*.pyc' -delete
CMD ["/usr/bin/ansible-lint"]
