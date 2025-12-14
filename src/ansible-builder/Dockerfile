FROM docker.io/ysebastia/python:3.12.10
RUN pipx install \
  ansible-builder==3.1.1 \
  && apk add --no-cache \
  bash=5.3.3-r1 \
  docker-cli=29.1.3-r0 \
  docker=29.1.3-r0 \
  openssl=3.5.4-r0 \
  py3-docker-py=7.1.0-r0 \
  py3-openssl=25.3.0-r0
CMD ["/root/.local/bin/ansible-builder"]
