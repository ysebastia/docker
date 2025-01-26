FROM ysebastia/ansible:2.18.1 AS builder
RUN pip install --no-cache-dir --use-pep517 \
  molecule==25.1.0 \
  molecule-plugins[docker]==23.7.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM ysebastia/python:3.12.8
COPY --from=builder /venv /venv
COPY requirements.yml /root/
COPY run_molecule.bash /usr/local/bin/
COPY coverage.bash /usr/local/bin/
RUN apk add --no-cache \
  bash=5.2.37-r0 \
  docker-cli=27.5.1-r0 \
  docker=27.5.1-r0 \
  openssl=3.3.2-r4 \
  py3-docker-py=7.1.0-r0 \
  py3-openssl=24.3.0-r0 \
  rsync=3.3.0-r0 \ 
  sshpass=1.10-r0 \
  sudo=1.9.16_p2-r0 \
  && mkdir -p /.cache /.ansible /.ansible_async \
  && chmod 777 /.cache /.ansible /.ansible_async \
  && ansible-galaxy collection install -r /root/requirements.yml --collections-path "/usr/share/ansible/collections" \
  && chmod +x /usr/local/bin/*.bash
