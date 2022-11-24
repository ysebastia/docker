FROM alpine:20221110
RUN apk add --no-cache ansible-lint=6.9.0-r0 \
  git=2.38.1-r0 \
  py3-filelock=3.8.0-r1 \
  py3-pip=22.3.1-r2 \
  yamllint=1.28.0-r1 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible \
  && pip install --no-cache-dir \
  black==22.10.0 \
  jsonschema==4.17.1 \
  wcmatch==8.4.1
CMD ["/usr/bin/ansible-lint"]
