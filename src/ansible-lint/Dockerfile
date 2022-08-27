FROM alpine:20220715
RUN apk add --no-cache ansible-lint=6.5.1-r0 \
  git=2.37.1-r1 \
  py3-filelock=3.4.2-r2 \
  py3-jsonschema=4.7.2-r2 \
  yamllint=1.27.1-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/usr/bin/ansible-lint"]
