FROM alpine:20230901
RUN apk add --no-cache \
  py3-filelock=3.12.2-r0 \
  py3-pip=23.2.1-r0 \
  py3-virtualenv=20.24.4-r0 \
  py3-wheel=0.41.0-r2 \
  py3-pylint=2.17.5-r0 \
  && python3 -m venv /opt/venv
CMD ["/usr/bin/pylint"]
