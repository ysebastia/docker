FROM alpine:20240807 AS builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  openssl=3.3.2-r4 \
  py3-openssl=24.1.0-r1 \
  py3-pip=24.3-r0 \
  py3-virtualenv=20.27.1-r0 \
  py3-wheel=0.43.0-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.3.1 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-core==2.18.1 \
  molecule==24.9.0 \
  molecule-plugins[docker]==23.5.3 \
  setuptools==75.5.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20240807
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
COPY requirements.yml /root/
COPY run_molecule.bash /usr/local/bin/
COPY coverage.bash /usr/local/bin/
RUN apk add --no-cache \
  bash=5.2.37-r0 \
  curl=8.11.0-r2 \
  docker-cli=27.3.1-r0 \
  docker=27.3.1-r0 \
  git=2.47.0-r0 \
  openssl=3.3.2-r4 \
  py3-docker-py=7.1.0-r0 \
  py3-openssl=24.1.0-r1 \
  python3=3.12.7-r1 \
  rsync=3.3.0-r0 \ 
  sshpass=1.10-r0 \
  sudo=1.9.16-r0 \
  && mkdir -p /.cache /.ansible /.ansible_async \
  && chmod 777 /.cache /.ansible /.ansible_async \
  && ansible-galaxy collection install -r /root/requirements.yml --collections-path "/usr/share/ansible/collections" \
  && chmod +x /usr/local/bin/*.bash
