FROM docker.io/ysebastia/python:3.12.10
RUN apk add --no-cache \
  gcc=15.2.0-r2 \
  musl-dev=1.2.5-r21 \
  openssl=3.5.4-r0 \
  py3-openssl=25.3.0-r0 \
  python3-dev=3.12.12-r0 \
  && pipx install ansible-lint==25.12.1 \
  && pipx install ansible-lint-junit==0.17.8 \
  && pipx install yamllint==1.37.1 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/root/.local/bin/ansible-lint"]
