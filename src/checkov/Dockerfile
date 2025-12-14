FROM docker.io/ysebastia/python:3.12.10
RUN apk add --no-cache \
  py3-setuptools-rust=1.12.0-r0 \
  && pipx install checkov==3.2.495
CMD ["/root/.local/bin/checkov"]
