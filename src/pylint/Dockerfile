FROM alpine:20230329
RUN apk add --no-cache \
  py3-filelock=3.12.0-r1 \
  py3-pip=23.1.2-r0 \
  py3-virtualenv=20.23.1-r0 \
  py3-wheel=0.40.0-r1 \
  py3-pylint=2.17.4-r0 \
  && python3 -m venv /opt/venv
CMD ["/usr/bin/pylint"]
