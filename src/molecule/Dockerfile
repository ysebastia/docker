FROM alpine:20230901 as builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  py3-pip=23.3.2-r0 \
  py3-virtualenv=20.25.0-r0 \
  py3-wheel=0.42.0-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.0 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-core==2.16.3 \
  molecule==24.2.0 \
  molecule-plugins[docker]==23.5.3 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20230901
COPY --from=builder /venv /venv
COPY requirements.yml /root/requirements.yml
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  bash=5.2.26-r0 \
  curl=8.6.0-r0 \
  docker=25.0.3-r0 \
  docker-cli=25.0.3-r0 \
  git=2.43.1-r0 \
  py3-docker-py=7.0.0-r0 \
  python3=3.11.7-r1 \
  rsync=3.2.7-r4 \ 
  sshpass=1.10-r0 \
  sudo=1.9.15_p5-r0 \
  && mkdir -p /.cache /.ansible /.ansible_async \
  && chmod 777 /.cache /.ansible /.ansible_async \
  && ansible-galaxy collection install -r /root/requirements.yml --collections-path "/usr/share/ansible/collections"
