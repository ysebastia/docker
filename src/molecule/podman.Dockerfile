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

RUN apk add --no-cache \
  bash=5.2.37-r0 \
  fuse-overlayfs=1.15-r0 \
  openssl=3.5.0-r0 \
  podman=5.5.0-r0 \
  py3-docker-py=7.1.0-r0 \
  py3-openssl=25.0.0-r0 \
  rsync=3.4.1-r0 \ 
  sshpass=1.10-r0 \
  sudo=1.9.16_p2-r1

RUN set -xe
RUN addgroup -S podman && adduser -S podman -G podman
RUN echo podman:10000:5000 > /etc/subuid
RUN echo podman:10000:5000 > /etc/subgid
RUN mkdir -p /home/podman/.cache /home/podman/.ansible /home/podman/.ansible_async /home/podman/.local/share/containers /home/podman/.config/containers
RUN chown -R podman:podman /venv /home/podman
RUN ansible-galaxy collection install -r /root/requirements.yml --collections-path "/usr/share/ansible/collections"
RUN chmod +x /usr/local/bin/*.bash

COPY --chown=podman podman-containers.conf /home/podman/.config/containers/containers.conf

VOLUME /var/lib/containers
VOLUME /home/podman/.local/share/containers

RUN mkdir -p /var/lib/shared/overlay-images \
             /var/lib/shared/overlay-layers \
             /var/lib/shared/vfs-images \
             /var/lib/shared/vfs-layers && \
    touch /var/lib/shared/overlay-images/images.lock && \
    touch /var/lib/shared/overlay-layers/layers.lock && \
    touch /var/lib/shared/vfs-images/images.lock && \
    touch /var/lib/shared/vfs-layers/layers.lock

USER podman