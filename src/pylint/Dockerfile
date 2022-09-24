FROM alpine:20220715
RUN apk add --no-cache \
  py3-pylint=2.15.0-r0 \
  file=5.42-r0 \
  && mkdir -p /root/.cache/pylint /.cache/pylint \
  && chmod 777 /root/.cache/pylint /.cache/pylint
CMD ["/usr/bin/pylint"]
