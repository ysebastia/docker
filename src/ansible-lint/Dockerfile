FROM alpine:20220715
RUN apk add --no-cache ansible-lint=6.4.0-r0 \
  git=2.37.1-r0 \
  py3-jsonschema=4.7.2-r1 \
  yamllint=1.27.1-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/usr/bin/ansible-lint"]
