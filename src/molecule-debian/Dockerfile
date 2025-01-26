FROM debian:12.9
ARG DEBIAN_FRONTEND=noninteractive
ARG HTTPS_PROXY
ARG HTTP_PROXY
ENV ANSIBLE_USER=ansible
ENV DEPLOY_GROUP=deployer
ENV SUDO_GROUP=sudo
ENV http_proxy=$HTTP_PROXY
ENV https_proxy=$HTTPS_PROXY

# hadolint ignore=DL3008
RUN apt-get update \
  && apt-get -y --no-install-recommends -o APT::Get::AllowUnauthenticated=true install \
  curl \
  git \
  grub-common \
  iproute2 \
  kmod \
  locales \
  python-is-python3 \
  python3-apt \
  python3-jmespath \
  python3-pip \
  ssh \
  sudo \
  systemd-cron \
  systemd-sysv \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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