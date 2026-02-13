redhat9 = docker.io/ysebastia/molecule:rhel-9.7
centos9 = docker.io/ysebastia/molecule:centos-stream9
rocky9 = docker.io/ysebastia/molecule:rockylinux-9.7

build: build_debian build_ubuntu build_redhat

build_debian:
	podman build . -f debian.Containerfile --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable -t docker.io/ysebastia/molecule:debian-13.2

build_ubuntu:
	podman build . -f ubuntu.Containerfile --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=ubuntu --build-arg VERSION_OS=22.04 -t docker.io/ysebastia/molecule:ubuntu-22.04
	podman build . -f ubuntu.Containerfile --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=ubuntu --build-arg VERSION_OS=24.04 -t docker.io/ysebastia/molecule:ubuntu-24.04

build_redhat: build_redhat9 build_redhat10

build_redhat9:
	podman build . -f redhat.Containerfile --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=registry.access.redhat.com/ubi9/ubi --build-arg VERSION_OS=9.7 -t $(redhat9)

build_rocky9:
	podman build . -f redhat.Containerfile --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=docker.io/rockylinux/rockylinux --build-arg VERSION_OS=9.7 -t $(rocky9)

build_centos9:
	podman build . -f redhat.Containerfile --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=quay.io/centos/centos --build-arg VERSION_OS=stream9 -t $(centos9)

build_redhat10:
	podman build . -f redhat.Containerfile --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=registry.access.redhat.com/ubi10/ubi --build-arg VERSION_OS=10.0 -t docker.io/ysebastia/molecule:rhel-10.1

run_redhat9:
	podman run --rm -ti --name redhat9 $(redhat9) /bin/bash

run_rocky9:
	podman run --rm -ti --name rocky9 $(rocky9) /bin/bash

run_centos9:
	podman run --rm -ti --name centos9 $(centos9) /bin/bash

molecule_test:
	cd extensions && molecule test