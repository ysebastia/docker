FROM alpine:20221110
RUN apk add --no-cache \
  py3-pylint=2.15.10-r0 \
  file=5.44-r0 \
  && mkdir -p /root/.cache/pylint /.cache/pylint \
  && chmod 777 /root/.cache/pylint /.cache/pylint
CMD ["/usr/bin/pylint"]
