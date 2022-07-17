FROM alpine:20220715
RUN apk add --no-cache ansible-lint=6.3.0-r1 \
  git=2.37.1-r0 \
  py3-jsonschema=4.7.2-r0 \
  yamllint=1.27.1-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/usr/bin/ansible-lint"]
