FROM alpine:20221110
RUN apk add --no-cache ansible-lint=6.8.6-r0 \
  git=2.38.1-r0 \
  py3-filelock=3.8.0-r0 \
  py3-jsonschema=4.7.2-r2 \
  yamllint=1.27.1-r0 \
  && addgroup -S ansible \
  && adduser -S ansible -G ansible -h /ansible \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
WORKDIR /ansible
USER ansible
CMD ["/usr/bin/ansible-lint"]
