debian_version = 13.7
redhat9_version = 9.9
redhat10_version = 10.3
debian = docker.io/ysebastia/molecule:debian-$(debian_version)
redhat9 = docker.io/ysebastia/molecule:rhel-$(redhat9_version)
redhat10 = docker.io/ysebastia/molecule:rhel-$(redhat10_version)

build: build_debian build_ubuntu build_redhat

build_debian:
	podman build . -f debian.Containerfile --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg VERSION_OS=$(debian_version) -t $(debian)

build_ubuntu:
	podman build . -f ubuntu.Containerfile --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=ubuntu --build-arg VERSION_OS=22.04 -t docker.io/ysebastia/molecule:ubuntu-22.04
	podman build . -f ubuntu.Containerfile --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=ubuntu --build-arg VERSION_OS=24.04 -t docker.io/ysebastia/molecule:ubuntu-24.04

build_redhat: build_redhat9 build_redhat10

build_redhat9:
	podman build . -f redhat.Containerfile --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=registry.access.redhat.com/ubi9/ubi --build-arg VERSION_OS=$(redhat9_version) -t $(redhat9)

build_redhat10:
	podman build . -f redhat.Containerfile --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=registry.access.redhat.com/ubi10/ubi --build-arg VERSION_OS=$(redhat10_version) -t $(redhat10)

run_redhat9:
	podman run --rm -ti --name redhat9 $(redhat9) /bin/bash

molecule_test:
	cd extensions && molecule test