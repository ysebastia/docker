FROM docker.io/ysebastia/python:3.12.10
RUN pipx install \
  ansible-core==2.20.1 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/root/.local/bin/ansible"]
