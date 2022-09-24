FROM alpine:20220715
RUN apk add --no-cache ansible-lint=6.5.2-r0 \
  git=2.37.3-r0 \
  py3-filelock=3.8.0-r0 \
  py3-jsonschema=4.7.2-r2 \
  yamllint=1.27.1-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible \
  && ansible-galaxy collection install ansible.posix
CMD ["/usr/bin/ansible-lint"]
