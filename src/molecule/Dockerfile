FROM alpine:20240329 as builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  openssl=3.3.1-r0 \
  py3-openssl=24.1.0-r1 \
  py3-pip=24.0-r2 \
  py3-virtualenv=20.26.2-r0 \
  py3-wheel=0.42.0-r1 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.1 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-core==2.17.1 \
  molecule==24.6.0 \
  molecule-plugins[docker]==23.5.3 \
  setuptools==70.0.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20240329
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
COPY requirements.yml /root/
COPY run_molecule.bash /usr/local/bin/
RUN apk add --no-cache \
  bash=5.2.26-r0 \
  curl=8.8.0-r0 \
  docker-cli=26.1.4-r1 \
  docker=26.1.4-r1 \
  git=2.45.2-r1 \
  openssl=3.3.1-r0 \
  py3-docker-py=7.0.0-r1 \
  py3-openssl=24.1.0-r1 \
  python3=3.12.3-r1 \
  rsync=3.3.0-r0 \ 
  sshpass=1.10-r0 \
  sudo=1.9.15_p5-r0 \
  && mkdir -p /.cache /.ansible /.ansible_async \
  && chmod 777 /.cache /.ansible /.ansible_async \
  && ansible-galaxy collection install -r /root/requirements.yml --collections-path "/usr/share/ansible/collections" \
  && chmod +x /usr/local/bin/*.bash
