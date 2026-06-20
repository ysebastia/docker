FROM docker.io/ysebastia/ansible:2.21.1 AS builder
USER root
RUN apk add --no-cache \
bash=5.3.9-r1 \
docker-cli=29.5.3-r0 \
docker=29.5.3-r0 \
openssl=3.5.7-r0 \
py3-docker-py=7.1.0-r1 \
py3-openssl=26.1.0-r0 \
rsync=3.4.3-r1 \ 
sshpass=1.10-r0 \
sudo=1.9.17_p2-r1
COPY docker.requirements.yml /root/requirements.yml
COPY run_molecule.bash /usr/local/bin/
COPY coverage.bash /usr/local/bin/
RUN ansible-galaxy collection install -r /root/requirements.yml --collections-path "/usr/share/ansible/collections" \
  && chmod +x /usr/local/bin/*.bash
USER ci
RUN pipx install molecule==26.4.0 \
  && pipx inject molecule molecule-plugins[docker]==25.8.12
RUN mkdir -p /home/ci/.cache /home/ci/.ansible /home/ci/.ansible_async \
  && chmod 777 /home/ci/.cache /home/ci/.ansible /home/ci/.ansible_async