ARG BASE_OS
ARG VERSION_OS

FROM $BASE_OS:$VERSION_OS
ARG HTTPS_PROXY
ARG HTTP_PROXY
ENV ANSIBLE_USER=ansible
ENV DEPLOY_GROUP=deployer
ENV SUDO_GROUP=wheel
ENV http_proxy=$HTTP_PROXY
ENV https_proxy=$HTTPS_PROXY

# hadolint ignore=DL3041
RUN dnf update -y \
  && dnf -y install \
  NetworkManager\
  firewalld \
  git \
  iproute \
  kmod \
  openssh-server \
  python3-jmespath \
  python3-pip \
  sudo \
  systemd-sysv \
  && ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' \
  && ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
  && ssh-keygen -q -t ed25519 -f /etc/ssh/ssh_host_ed25519_key  -N '' \
  && dnf clean all && rm -rf /tmp/* /var/tmp/*

# https://hub.docker.com/_/centos/
RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp*

# https://ansible.readthedocs.io/projects/molecule/guides/docker-rootless/#docker-with-non-privileged-user
RUN set -xe \
  && groupadd -r ${ANSIBLE_USER} \
  && groupadd -r ${DEPLOY_GROUP} \
  && useradd -m -g ${ANSIBLE_USER} ${ANSIBLE_USER} \
  && usermod -aG ${SUDO_GROUP} ${ANSIBLE_USER} \
  && usermod -aG ${DEPLOY_GROUP} ${ANSIBLE_USER} \
  && sed -i "/^%${SUDO_GROUP}/s/ALL\$/NOPASSWD:ALL/g" /etc/sudoers

VOLUME [ "/sys/fs/cgroup" ]

CMD [ "/lib/systemd/systemd" ]