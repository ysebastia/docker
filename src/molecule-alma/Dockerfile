FROM almalinux:9.3

# hadolint ignore=DL3041
RUN dnf update -y \
  && dnf -y install \
  git \
  kmod \
  python3-jmespath \
  python3-pip \
  openssh \
  sudo \
  systemd-sysv \
  && dnf clean all && rm -rf /tmp/* /var/tmp/*

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp*

VOLUME [ "/sys/fs/cgroup", "/tmp", "/run" ]

CMD [ "/lib/systemd/systemd" ]