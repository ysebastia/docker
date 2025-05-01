FROM docker.io/ysebastia/ansible:2.18.5 AS builder
RUN pip install --no-cache-dir --use-pep517 \
  molecule==25.4.0 \
  molecule-plugins[docker]==23.7.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM docker.io/ysebastia/python:3.12.10
COPY --from=builder /venv /venv
COPY requirements.yml /root/
COPY run_molecule.bash /usr/local/bin/
COPY coverage.bash /usr/local/bin/
RUN apk add --no-cache \
  bash=5.2.37-r0 \
  docker-cli=28.1.1-r1 \
  docker=28.1.1-r1 \
  openssl=3.5.0-r0 \
  py3-docker-py=7.1.0-r0 \
  py3-openssl=25.0.0-r0 \
  rsync=3.4.1-r0 \ 
  sshpass=1.10-r0 \
  sudo=1.9.16_p2-r0 \
  && mkdir -p /.cache /.ansible /.ansible_async \
  && chmod 777 /.cache /.ansible /.ansible_async \
  && ansible-galaxy collection install -r /root/requirements.yml --collections-path "/usr/share/ansible/collections" \
  && chmod +x /usr/local/bin/*.bash
