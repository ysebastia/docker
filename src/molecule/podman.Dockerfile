FROM docker.io/ysebastia/ansible:2.18.6 AS builder
RUN pip install --no-cache-dir --use-pep517 \
  molecule==25.4.0 \
  molecule-plugins[podman]==23.7.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM docker.io/ysebastia/python:3.12.10
COPY --from=builder /venv /venv
COPY podman.requirements.yml /root/requirements.yml
COPY run_molecule.bash /usr/local/bin/
COPY coverage.bash /usr/local/bin/
COPY containers/*.conf /etc/containers/
COPY iptables.conf /etc/modules-load.d/iptables.conf

RUN apk add --no-cache \
  bash=5.2.37-r0 \
  fuse-overlayfs=1.15-r0 \
  iptables=1.8.11-r1 \
  openssl=3.5.0-r0 \
  podman=5.5.0-r0 \
  py3-openssl=25.0.0-r0 \
  rsync=3.4.1-r0 \ 
  slirp4netns=1.3.1-r0 \
  sshpass=1.10-r0 \
  sudo=1.9.16_p2-r1 \
  && addgroup --gid 1001 -S podman \
  && adduser --uid 1001 -S podman -G podman \
  && echo podman:100000:65536 > /etc/subuid \
  && echo podman:100000:65536 > /etc/subgid \
  && mkdir -p /home/podman/.cache /home/podman/.ansible /home/podman/.ansible_async /home/podman/.local/share/containers /home/podman/.config/containers \
  && chown -R podman:podman /venv /home/podman \
  && ansible-galaxy collection install -r /root/requirements.yml --collections-path "/usr/share/ansible/collections" \
  && chmod +x /usr/local/bin/*.bash
  
VOLUME /var/lib/containers